import 'package:drift/drift.dart';
import 'businesses.dart';

@DataClassName('Contact')
class Contacts extends Table {
  TextColumn get id => text()();
  TextColumn get businessId => text().references(Businesses, #id, onDelete: KeyAction.cascade)();
  
  TextColumn get firstName => text()();
  TextColumn get lastName => text().nullable()();
  TextColumn get jobTitle => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get linkedinUrl => text().nullable()();
  BoolColumn get isPrimary => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  
  // Sync state metadata
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
