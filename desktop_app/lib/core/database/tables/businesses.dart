import 'package:drift/drift.dart';

@DataClassName('Business')
class Businesses extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get website => text().nullable()();
  TextColumn get industry => text().nullable()();
  TextColumn get locationCity => text().nullable()();
  TextColumn get locationCountry => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  RealColumn get googleRating => real().nullable()();
  IntColumn get leadScore => integer().withDefault(const Constant(0))();
  TextColumn get status => text().withDefault(const Constant('New Lead'))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  
  // Sync state metadata
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
