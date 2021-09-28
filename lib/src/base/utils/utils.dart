import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension UIExt on BuildContext {
  double topSpace() => MediaQuery.of(this).padding.top;

  double appBarHeight() => AppBar().preferredSize.height;

  Size screenSize() => MediaQuery.of(this).size;

  ThemeData appTheme() => Theme.of(this);

  TextTheme textTheme() => Theme.of(this).textTheme;

  void closeKeyboardIfOpen() {
    //FocusScope.of(context).requestFocus(new FocusNode());
    FocusScopeNode currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
  }
}

extension DblExt on double {
  double percent(double percent) => (this / 100) * percent;
}

extension DateExt on DateTime {
  String get toFormat1 => DateFormat("MMM d, y").format(this);
  DateTime setTime(TimeOfDay timeOfDay) {
    var dt = subtract(Duration(
        hours: hour - timeOfDay.hour, minutes: minute - timeOfDay.minute));
    return dt;
  }
}

enum SnackbarType { ERROR }

extension SnackExt on SnackbarService {
  SnackbarConfig get defaultConfigs => SnackbarConfig(
      backgroundColor: AppColors.primary, messageColor: Colors.white);

  SnackbarConfig get errorConfigs => SnackbarConfig(
      margin: EdgeInsets.all(10),
      borderRadius: 10,
      animationDuration: Duration(milliseconds: 500),
      backgroundColor: Colors.red,
      messageColor: Colors.white);

  init() {
    registerSnackbarConfig(defaultConfigs);
    registerCustomSnackbarConfig(
        variant: SnackbarType.ERROR, config: errorConfigs);
  }

  showErrorMessage(String message,
      {Duration duration = const Duration(seconds: 5)}) {
    this.showCustomSnackBar(
        message: message,
        variant: SnackbarType.ERROR,
        duration: duration,
        onTap: NavService.pop);
  }
}

double calculateTimeValue(TimeOfDay start, TimeOfDay end) =>
    (((end.hour) + (end.minute / 60)) - (start.hour + (start.minute / 60)));

List<TimeOfDay> buildTimeSlots(
    double sectionSize, TimeOfDay start, TimeOfDay end) {
  var totalTimeVal = calculateTimeValue(start, end);
  sectionSize += 0.5;
  var intervalValue = totalTimeVal / (sectionSize);
  List<TimeOfDay> splitValues = [];
  List<String> splittedIntervalValue = "$intervalValue".split(".");
  int intervalHours = int.parse(splittedIntervalValue.first);
  var intervalMinutes = double.parse("0." + splittedIntervalValue.last) * 60;
  for (var i = 0; i < sectionSize; i++) {
    splitValues.add(TimeOfDay(
        hour: (splitValues.isNotEmpty ? splitValues.last.hour : start.hour) +
            intervalHours,
        minute: intervalMinutes.round()));
  }
  /*
  var finalMins = finalValue - finalValue.truncate();
  int finalHour =
      int.parse("$finalValue".split(".").first) + splitValues.last.hour;

  splitValues.add(TimeOfDay(hour: finalHour, minute: (finalMins * 60).round()));
  */
  return splitValues;
}

heightValueOnChange(
    ReactiveValue<int> heightFt, ReactiveValue<int> heightIn, String value) {
  try {
    if (value.isNotEmpty) {
      if (value.contains(".")) {
        heightFt.value = int.parse(value.split(".").first);
        if (value.split(".").last.isNotEmpty) {
          heightIn.value = int.parse(value.split(".").last);
        }
      } else {
        heightFt.value = int.parse(value);
        heightIn.value = 0;
      }
    } else {
      heightFt.value = 0;
      heightIn.value = 0;
    }
  } catch (e) {
    heightFt.value = 0;
    heightIn.value = 0;
  }
}

enum PrefKeys { GOAL_CREATION_DATE, CHECK_IN_COUNT }
enum PrefDataType { STRING, INT, BOOL, DOUBLE, LIST_OF_STRINGS }

saveDataInPref(PrefKeys key, dynamic value, PrefDataType type) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<PrefDataType, Function> prefFuns = {
    PrefDataType.STRING: prefs.setString,
    PrefDataType.INT: prefs.setInt,
    PrefDataType.DOUBLE: prefs.setDouble,
    PrefDataType.BOOL: prefs.setBool,
    PrefDataType.LIST_OF_STRINGS: prefs.setStringList,
  };

  await prefFuns[type]!(describeEnum(key), value);
}

Future<dynamic> getDataFromPref(PrefKeys key, PrefDataType type) async {
  var prefs = (await SharedPreferences.getInstance());
  Map<PrefDataType, Function> prefFuns = {
    PrefDataType.STRING: prefs.getString,
    PrefDataType.INT: prefs.getInt,
    PrefDataType.DOUBLE: prefs.getDouble,
    PrefDataType.BOOL: prefs.getBool,
    PrefDataType.LIST_OF_STRINGS: prefs.getStringList,
  };
  return await prefFuns[type]!(describeEnum(key));
}
