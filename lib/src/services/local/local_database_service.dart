import 'package:diet_app/src/base/utils/Constants.dart';
import 'package:diet_app/src/models/db/base/local_database.dart';
import 'package:diet_app/src/models/db/daily_intake/daily_intake_dao.dart';

class LocalDatabaseService {
  late LocalDatabase _localDatabase;

  LocalDatabase get db => _localDatabase;
  DailyInakeDao get intakeDao => _localDatabase.dailyIntakeDao;

  init() async {
    _localDatabase = await $FloorLocalDatabase
        .databaseBuilder(Constants.mainLocalDbName)
        .build();
  }
}
