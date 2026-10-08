import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class Inspections extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get clientId => text().unique()();
  TextColumn get serverId => text().nullable()();

  TextColumn get workOrderId => text()();
  TextColumn get observation => text()();
  TextColumn get photoPath => text().nullable()();

  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();

  DateTimeColumn get capturedAt => dateTime()();

  TextColumn get status => text().withDefault(const Constant('draft'))();

  TextColumn get errorMessage => text().nullable()();
  DateTimeColumn get syncedAt => dateTime().nullable()();
}

class CachedWorkOrders extends Table {
  TextColumn get id => text()();
  TextColumn get code => text()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get address => text()();
  TextColumn get priority => text()();
  TextColumn get status => text()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Inspections, CachedWorkOrders])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 3) {
        await m.drop(inspections);
        await m.createAll();
        return;
      }
      if (from < 4) {
        await m.createTable(cachedWorkOrders);
      }
    },
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'inspecampo.sqlite'));
    return NativeDatabase(file);
  });
}

final AppDatabase appDatabase = AppDatabase();