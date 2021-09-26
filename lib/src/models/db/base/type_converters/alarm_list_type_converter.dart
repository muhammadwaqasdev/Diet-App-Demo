import 'dart:convert';

import 'package:diet_app/src/models/goal.dart';
import 'package:floor/floor.dart';

class AlarmListTypeConoverter extends TypeConverter<List<AlarmData>, String> {
  @override
  List<AlarmData> decode(String databaseValue) {
    List<AlarmData> alarms = [];
    var decodedValue = jsonDecode(databaseValue);
    for (var food in (decodedValue as List<dynamic>)) {
      alarms.add(AlarmData.fromJson(food));
    }
    return alarms;
  }

  @override
  String encode(List<AlarmData> value) {
    return jsonEncode(value.map((e) => e.toJson()).toList());
  }
}
