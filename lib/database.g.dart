// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  FitbitActivityDao? _fitbitActivityDaoInstance;

  FitbitHeartDao? _fitbitHeartDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
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
            'CREATE TABLE IF NOT EXISTS `FitbitActivity` (`id` INTEGER NOT NULL, `name` TEXT, `description` TEXT, `calories` REAL, `distance` REAL, `duration` REAL, `dateOfMonitoring` INTEGER, `startTime` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FitbitHeart` (`id` INTEGER, `dateOfMonitoring` INTEGER, `restingHeartRate` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  FitbitActivityDao get fitbitActivityDao {
    return _fitbitActivityDaoInstance ??=
        _$FitbitActivityDao(database, changeListener);
  }

  @override
  FitbitHeartDao get fitbitHeartDao {
    return _fitbitHeartDaoInstance ??=
        _$FitbitHeartDao(database, changeListener);
  }
}

class _$FitbitActivityDao extends FitbitActivityDao {
  _$FitbitActivityDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fitbitActivityInsertionAdapter = InsertionAdapter(
            database,
            'FitbitActivity',
            (FitbitActivity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'description': item.description,
                  'calories': item.calories,
                  'distance': item.distance,
                  'duration': item.duration,
                  'dateOfMonitoring': item.dateOfMonitoring,
                  'startTime': item.startTime
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FitbitActivity> _fitbitActivityInsertionAdapter;

  @override
  Future<List<FitbitActivity>> all() async {
    return _queryAdapter.queryList(
        'SELECT * FROM FitbitActivity ORDER BY dateOfMonitoring desc',
        mapper: (Map<String, Object?> row) => FitbitActivity(
            row['id'] as int,
            row['name'] as String?,
            row['description'] as String?,
            row['calories'] as double?,
            row['distance'] as double?,
            row['duration'] as double?,
            row['dateOfMonitoring'] as int?,
            row['startTime'] as int?));
  }

  @override
  Future<FitbitActivity?> mostRecent() async {
    return _queryAdapter.query(
        'SELECT * FROM FitbitActivity ORDER BY dateOfMonitoring desc LIMIT 1',
        mapper: (Map<String, Object?> row) => FitbitActivity(
            row['id'] as int,
            row['name'] as String?,
            row['description'] as String?,
            row['calories'] as double?,
            row['distance'] as double?,
            row['duration'] as double?,
            row['dateOfMonitoring'] as int?,
            row['startTime'] as int?));
  }

  @override
  Future<FitbitActivity?> find(int id) async {
    return _queryAdapter.query('SELECT * FROM FitbitActivity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => FitbitActivity(
            row['id'] as int,
            row['name'] as String?,
            row['description'] as String?,
            row['calories'] as double?,
            row['distance'] as double?,
            row['duration'] as double?,
            row['dateOfMonitoring'] as int?,
            row['startTime'] as int?),
        arguments: [id]);
  }

  @override
  Future<FitbitActivity?> lastInserted() async {
    return _queryAdapter.query(
        'SELECT * FROM FitbitActivity ORDER BY id desc LIMIT 1',
        mapper: (Map<String, Object?> row) => FitbitActivity(
            row['id'] as int,
            row['name'] as String?,
            row['description'] as String?,
            row['calories'] as double?,
            row['distance'] as double?,
            row['duration'] as double?,
            row['dateOfMonitoring'] as int?,
            row['startTime'] as int?));
  }

  @override
  Future<void> create(FitbitActivity fitbitActivity) async {
    await _fitbitActivityInsertionAdapter.insert(
        fitbitActivity, OnConflictStrategy.abort);
  }
}

class _$FitbitHeartDao extends FitbitHeartDao {
  _$FitbitHeartDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _fitbitHeartInsertionAdapter = InsertionAdapter(
            database,
            'FitbitHeart',
            (FitbitHeart item) => <String, Object?>{
                  'id': item.id,
                  'dateOfMonitoring': item.dateOfMonitoring,
                  'restingHeartRate': item.restingHeartRate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FitbitHeart> _fitbitHeartInsertionAdapter;

  @override
  Future<List<FitbitHeart>> all() async {
    return _queryAdapter.queryList(
        'SELECT * FROM FitbitHeart ORDER BY dateOfMonitoring desc',
        mapper: (Map<String, Object?> row) => FitbitHeart(
            id: row['id'] as int?,
            dateOfMonitoring: row['dateOfMonitoring'] as int?,
            restingHeartRate: row['restingHeartRate'] as int?));
  }

  @override
  Future<FitbitHeart?> mostRecent() async {
    return _queryAdapter.query(
        'SELECT * FROM FitbitHeart ORDER BY dateOfMonitoring desc LIMIT 1',
        mapper: (Map<String, Object?> row) => FitbitHeart(
            id: row['id'] as int?,
            dateOfMonitoring: row['dateOfMonitoring'] as int?,
            restingHeartRate: row['restingHeartRate'] as int?));
  }

  @override
  Future<FitbitHeart?> lastInserted() async {
    return _queryAdapter.query(
        'SELECT * FROM FitbitHeart ORDER BY id desc LIMIT 1',
        mapper: (Map<String, Object?> row) => FitbitHeart(
            id: row['id'] as int?,
            dateOfMonitoring: row['dateOfMonitoring'] as int?,
            restingHeartRate: row['restingHeartRate'] as int?));
  }

  @override
  Future<void> create(FitbitHeart fitbitHeart) async {
    await _fitbitHeartInsertionAdapter.insert(
        fitbitHeart, OnConflictStrategy.abort);
  }
}
