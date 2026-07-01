import 'package:drift/drift.dart';
import 'businesses.dart';

@DataClassName('Note')
class Notes extends Table {
  TextColumn get id => text()();
  TextColumn get businessId => text().references(Businesses, #id, onDelete: KeyAction.cascade)();
  TextColumn get authorId => text().nullable()();
  
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  
  // Sync state metadata
  BoolColumn get isSynced => boolean().withDefault(const Constant(true))();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
