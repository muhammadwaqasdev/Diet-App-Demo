import 'package:diet_app/src/models/db/daily_intake/daily_intake.dart';
import 'package:floor/floor.dart';

@dao
abstract class DailyInakeDao {
  @Query('SELECT * FROM daily_intake')
  Future<List<DailyIntake>> getAllIntakes();

  @Query('SELECT * FROM daily_intake WHERE date = :millisecondsSinceEpoch')
  Stream<DailyIntake?> findIntakeByDate(int millisecondsSinceEpoch);

  @Query('SELECT * FROM daily_intake WHERE id = :id')
  Future<DailyIntake?> findIntakeById(int id);

  @insert
  Future<void> insertDailyIntake(DailyIntake dailyIntake);

  @delete
  Future<void> deleteDailyIntake(DailyIntake dailyIntake);

  @update
  Future<void> updateDailyIntake(DailyIntake dailyIntake);

  @Query("DELETE FROM daily_intake")
  Future<void> clearIntakes();
}
