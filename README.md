# InspeCampo

App Flutter de inspeção de campo — desafio técnico para a vaga de Desenvolvedor Mobile Flutter (Orbytis).

Permite que técnicos de campo visualizem ordens de serviço, registrem inspeções (observação, foto e localização) mesmo sem conexão com a internet, e sincronizem esses dados com o servidor assim que a conexão estiver disponível.

## Sumário

- [Arquitetura](#arquitetura)
- [Como rodar o projeto](#como-rodar-o-projeto)
- [Ambiente testado](#ambiente-testado)
- [Funcionalidades por tela](#funcionalidades-por-tela)
- [Fila de sincronização](#fila-de-sincronização)
- [Decisões técnicas](#decisões-técnicas)
- [Pendências e próximos passos](#pendências-e-próximos-passos)

## Arquitetura

O projeto segue separação em camadas:

```
lib/
├── models/       # Formato dos dados (User, WorkOrder)
├── services/     # Comunicação com a API (AuthService, WorkOrdersService, SyncService)
├── data/         # Persistência local (Drift/SQLite, InspectionRepository)
├── screens/      # Telas (UI) + estado local
└── theme/        # Cores, labels e estilos compartilhados
```

**Por que essa separação:** cada camada tem uma responsabilidade única. As telas não sabem como os dados são buscados ou salvos, elas só chamam métodos de `services`/`data` com nomes que descrevem a intenção (`login()`, `createDraft()`, `syncAll()`). Isso facilita testar e trocar peças isoladamente sem afetar o restante do app.

**Sobre gerenciamento de estado:** o estado da UI é gerenciado localmente com `StatefulWidget`/`setState`, enquanto a lógica de acesso a dados e sincronização permanece isolada em `services`/`data`. Dessa forma, a ausência de um gerenciador de estado externo não mistura responsabilidades entre UI e acesso aos dados. Optei por não usar BLoC (que é diferencial desejável, não obrigatório) para priorizar robustecer e testar bem o fluxo obrigatório dentro do prazo do desafio, em vez de introduzir uma camada extra com risco de bugs de última hora.

**Por que Drift (SQLite) para o banco local:** a fila de sincronização exige consultas por status (`pending`, `failed`, etc.) e atualizações pontuais de registros, operações naturais em SQL. Drift oferece tipagem forte sobre SQLite com geração de código, reduzindo erros manuais de mapeamento. Hive é mais orientada a armazenamento chave-valor simples; para este caso, com consultas condicionais e atualizações parciais, Drift se encaixou melhor.

**Principais pacotes:**

| Pacote | Uso                                                                |
|--------|--------------------------------------------------------------------|
| `dio`  | Cliente HTTP, com interceptor para token automático                |
| `drift`| Banco local SQLite                                                 |
| `flutter_secure_storage` | Persistência segura do token de autenticação     |
| `shared_preferences` | Persistência de dados não sensíveis (usuário logado) |
| `image_picker` | Captura de foto (câmera ou galeria)                        |
| `geolocator` | Captura de GPS                                               |
| `connectivity_plus` | Detecção de volta de conexão para sync automático     |
| `uuid` | Geração do `clientId` para idempotência                            |

## Como rodar o projeto

### Pré-requisitos

- Flutter SDK instalado (`flutter --version` para conferir)
- Node.js instalado (`node -v` para conferir)
- Emulador Android configurado, ou dispositivo físico com depuração USB ativada

### 1. Subir o mock-api

```bash
cd mock-api
npm install
npm start
```

O servidor sobe em `http://localhost:3000`. Deixe esse terminal aberto.

### 2. Rodar o app Flutter

Em outro terminal:

```bash
cd inspecao_campo
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

O comando `build_runner` é necessário porque o código de acesso ao banco local (Drift) é gerado automaticamente — sem rodar esse comando, o projeto não compila.

**Importante:** no emulador Android, a chamada à API já está configurada para usar `10.0.2.2` automaticamente (endereço que o emulador reconhece como "localhost do computador hospedeiro"). Em dispositivo Android físico, a API utiliza localhost conforme a configuração de ambiente.

Para testar GPS no emulador, é necessário configurar uma localização simulada em **Extended Controls → Location → Send**, já que o emulador não possui GPS físico.

### Credenciais de teste

| E-mail                   | Senha      |
|--------------------------|------------|
| `tecnico@orbytis.com.br` | `123456`   |
| `admin@orbytis.com.br`   | `admin123` |

*(Ambas funcionam de forma idêntica no app — não há diferenciação de comportamento por papel, ver seção de decisões técnicas.)*

## Ambiente testado

- Flutter 3.41.6 (channel stable)
- Dart 3.11.4
- Emulador Android (sdk gphone64 x86 64)

## Funcionalidades por tela

### Login
- Autenticação via `POST /auth/login`, com token persistido de forma segura.
- Ao abrir o app, uma tela de splash verifica se há um token salvo: se houver, vai direto para a lista de OS; caso contrário, redireciona para o login, bloqueando o acesso a rotas autenticadas sem sessão válida.
- Logout remove o token e os dados do usuário armazenados localmente, retornando ao login.

### Lista de ordens de serviço
- Consome `GET /work-orders`, exibindo título, endereço, prioridade e status.
- Cobre os 4 estados obrigatórios: **loading**, **vazio**, **erro** (com opção de retry) e **sucesso** — com **pull-to-refresh** disponível em todos eles.
- Em caso de sessão expirada (401), o botão de recuperação leva direto ao login em vez de tentar recarregar (reenviar com token inválido sempre falharia de novo).

### Formulário de inspeção
- Campos de observação, foto (câmera ou galeria) e localização (GPS).
- Botão **Salvar rascunho** (grava localmente com status `draft`, permitindo campos incompletos) e **Concluir inspeção** (valida observação com mínimo de 10 caracteres, foto e GPS presentes, e grava como `pending`, pronta para sincronização).

### Histórico
- Lista todas as inspeções salvas localmente, mais recentes primeiro.
- **Filtro por status de sincronização** (Todos / Rascunho / Pendente / Sincronizado / Falhou), via chips de seleção no topo da tela.
- Cada item exibe indicação visual clara do status (cor + label), e itens `failed` exibem a mensagem de erro específica junto com o botão **Tentar novamente**.
- Botão de sincronização manual no topo da tela.

## Fila de sincronização

A fila de sincronização é o principal fluxo offline do aplicativo. 

Cada inspeção passa por até 4 estados:

draft → pending → synced
↓
failed → (retry) → pending → synced


- **draft**: rascunho salvo localmente, ainda incompleto (pode faltar foto/GPS)
- **pending**: inspeção concluída, aguardando envio para o servidor
- **synced**: enviada com sucesso, contém o `serverId` retornado pela API
- **failed**: tentativa de envio falhou; contém a mensagem de erro específica, exibida no histórico

**Como o envio funciona:** cada inspeção nasce com um `clientId` (UUID) gerado no momento da criação. O envio é feito via `multipart/form-data` para `POST /inspections`, incluindo o arquivo de foto. Como o `clientId` é sempre o mesmo em reenvios, a API trata isso de forma idempotente, reenviar uma inspeção já sincronizada não cria duplicata.

**Gatilhos de sincronização:**
1. **Manual** — botão de sync na tela de Histórico
2. **Automático** — dispara sozinho ao detectar volta de conexão (`connectivity_plus`), sem exigir ação do usuário
3. **Retry individual** — botão "Tentar novamente" em itens com status `failed`, reenvia apenas aquele item

Uma flag interna (`_isSyncing`) impede que duas sincronizações rodem ao mesmo tempo (ex: usuário aperta o botão manual enquanto o automático já está em andamento).

**Persistência validada:** testado manualmente criando inspeções, encerrando o aplicativo completamente (kill do processo, não apenas hot restart) e reabrindo, as inspeções e seus respectivos status permaneceram intactos na tela de histórico.

**Fluxo offline→online testado manualmente:** criação de inspeção → pending → desligar conexão → falha de sync → status failed com mensagem de erro → reconexão → retry → synced.

## Decisões técnicas

### Autenticação
- Token persistido via `flutter_secure_storage` (dado sensível, armazenamento criptografado).
- Dados do usuário logado (nome, email, papel) persistidos via `shared_preferences` — dado não sensível, dispensa criptografia.
- Interceptor no Dio injeta automaticamente o header `Authorization: Bearer <token>` em toda requisição autenticada, evitando repetição em cada service.
- Saudação com nome do usuário logado ("Olá, [nome]") foi implementada por boa prática de UX, não é requisito do desafio.
- **Fora de escopo:** não implementei diferenciação de comportamento/UI por papel (`admin` vs `field_technician`). O enunciado não exige isso, e o contrato de API não define nenhuma regra condicionada a papel.

### Listagem de ordens de serviço
- O model `WorkOrder` mapeia os campos exibidos na tela, além de `code`, `latitude` e `longitude`, reaproveitados no formulário de inspeção.
- As cores de status da OS (aberta/em andamento/concluída) reaproveitam a mesma paleta usada nos status de sincronização, já que representam a mesma semântica visual (neutro / em andamento / concluído), evita duplicar cores no design system.

### Persistência local e formulário
- Banco local via Drift (SQLite). Campos de foto e GPS são opcionais na tabela, pois um rascunho pode ser salvo parcialmente, só se tornam obrigatórios no momento de concluir a inspeção, quando o app valida as regras do contrato.
- Foto é salva como arquivo no diretório de documentos do app (o banco guarda apenas o caminho, não os bytes), mantendo o banco leve.
- O fluxo de "Concluir inspeção" grava a inspeção diretamente como `pending` (não passa por `draft`), já que ela nunca foi de fato um rascunho nesse caminho.
- Opção de foto por câmera ou galeria (menu de escolha), cobrindo tanto o uso real em campo quanto testes em emulador sem câmera física.

## Pendências e próximos passos

Com mais tempo, os próximos pontos seriam priorizados:

- **Testes automatizados**: cobertura unitária do `InspectionRepository` e do `SyncService`, que concentram a lógica mais crítica do desafio (persistência e sincronização).
- **Tratamento de sessão expirada no retry do histórico**: hoje, um item `failed` por 401 tentaria reenviar e falhar novamente pelo mesmo motivo, o mesmo tratamento aplicado na listagem de OS (redirecionar para login) poderia ser estendido para esse fluxo.
- **Tela de detalhe da inspeção já registrada**: os cards do histórico não são clicáveis atualmente, não é um requisito do desafio, mas seria uma melhoria natural de UX.
- **Filtro por status na listagem de OS** (`GET /work-orders?status=...`): disponível no contrato da API, mas não implementado, já que não é requisito obrigatório da listagem (não confundir com o filtro por status de sincronização no histórico, que já está implementado!).
- **Refinamento visual geral**: o app prioriza funcionalidade e cobertura dos critérios técnicos; uma segunda passada de UI/UX poderia melhorar o acabamento visual das telas.

## Estrutura do repositório
```
desafio-flutter-orbytis/
├── README.md       # Este arquivo
├── mock-api/       # Servidor mock da API (Node.js)
└── inspecao_campo/ # Aplicativo Flutter
```
