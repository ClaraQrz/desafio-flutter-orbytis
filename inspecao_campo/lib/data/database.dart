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
  TextColumn get condition => text().nullable()();
  TextColumn get photoPath => text().nullable()();

  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();

  DateTimeColumn get capturedAt => dateTime()();

  TextColumn get status => text().withDefault(const Constant('draft'))();

  TextColumn get errorMessage => text().nullable()();
  DateTimeColumn get syncedAt => dateTime().nullable()();
}

@DriftDatabase(tables: [Inspections])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      await m.drop(inspections);
      await m.createAll();
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