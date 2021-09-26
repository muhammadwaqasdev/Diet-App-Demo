// database.dart

// required package imports
import 'dart:async';

import 'package:diet_app/src/models/db/daily_intake/daily_intake.dart';
import 'package:diet_app/src/models/db/daily_intake/daily_intake_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'type_converters/alarm_list_type_converter.dart';
import 'type_converters/date_time_converter.dart';

part 'local_database.g.dart'; // the generated code will be there

@TypeConverters([AlarmListTypeConoverter, DateTimeConverter])
@Database(version: 1, entities: [DailyIntake])
abstract class LocalDatabase extends FloorDatabase {
  DailyInakeDao get dailyIntakeDao;
}
