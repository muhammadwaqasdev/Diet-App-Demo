// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorLocalDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$LocalDatabaseBuilder databaseBuilder(String name) =>
      _$LocalDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$LocalDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$LocalDatabaseBuilder(null);
}

class _$LocalDatabaseBuilder {
  _$LocalDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$LocalDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$LocalDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<LocalDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$LocalDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$LocalDatabase extends LocalDatabase {
  _$LocalDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  DailyInakeDao? _dailyIntakeDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `daily_intake` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date` INTEGER NOT NULL, `alams` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  DailyInakeDao get dailyIntakeDao {
    return _dailyIntakeDaoInstance ??=
        _$DailyInakeDao(database, changeListener);
  }
}

class _$DailyInakeDao extends DailyInakeDao {
  _$DailyInakeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _dailyIntakeInsertionAdapter = InsertionAdapter(
            database,
            'daily_intake',
            (DailyIntake item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'alams': _alarmListTypeConoverter.encode(item.alams)
                },
            changeListener),
        _dailyIntakeUpdateAdapter = UpdateAdapter(
            database,
            'daily_intake',
            ['id'],
            (DailyIntake item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'alams': _alarmListTypeConoverter.encode(item.alams)
                },
            changeListener),
        _dailyIntakeDeletionAdapter = DeletionAdapter(
            database,
            'daily_intake',
            ['id'],
            (DailyIntake item) => <String, Object?>{
                  'id': item.id,
                  'date': _dateTimeConverter.encode(item.date),
                  'alams': _alarmListTypeConoverter.encode(item.alams)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DailyIntake> _dailyIntakeInsertionAdapter;

  final UpdateAdapter<DailyIntake> _dailyIntakeUpdateAdapter;

  final DeletionAdapter<DailyIntake> _dailyIntakeDeletionAdapter;

  @override
  Future<List<DailyIntake>> getAllIntakes() async {
    return _queryAdapter.queryList('SELECT * FROM daily_intake',
        mapper: (Map<String, Object?> row) => DailyIntake(
            row['id'] as int?,
            _dateTimeConverter.decode(row['date'] as int),
            _alarmListTypeConoverter.decode(row['alams'] as String)));
  }

  @override
  Stream<DailyIntake?> findIntakeByDate(int millisecondsSinceEpoch) {
    return _queryAdapter.queryStream(
        'SELECT * FROM daily_intake WHERE date = ?1',
        mapper: (Map<String, Object?> row) => DailyIntake(
            row['id'] as int?,
            _dateTimeConverter.decode(row['date'] as int),
            _alarmListTypeConoverter.decode(row['alams'] as String)),
        arguments: [millisecondsSinceEpoch],
        queryableName: 'daily_intake',
        isView: false);
  }

  @override
  Future<DailyIntake?> findIntakeById(int id) async {
    return _queryAdapter.query('SELECT * FROM daily_intake WHERE id = ?1',
        mapper: (Map<String, Object?> row) => DailyIntake(
            row['id'] as int?,
            _dateTimeConverter.decode(row['date'] as int),
            _alarmListTypeConoverter.decode(row['alams'] as String)),
        arguments: [id]);
  }

  @override
  Future<void> insertDailyIntake(DailyIntake dailyIntake) async {
    await _dailyIntakeInsertionAdapter.insert(
        dailyIntake, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateDailyIntake(DailyIntake dailyIntake) async {
    await _dailyIntakeUpdateAdapter.update(
        dailyIntake, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteDailyIntake(DailyIntake dailyIntake) async {
    await _dailyIntakeDeletionAdapter.delete(dailyIntake);
  }
}

// ignore_for_file: unused_element
final _alarmListTypeConoverter = AlarmListTypeConoverter();
final _dateTimeConverter = DateTimeConverter();
