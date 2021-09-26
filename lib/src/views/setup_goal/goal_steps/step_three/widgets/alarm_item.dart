import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/models/goal.dart';
import 'package:diet_app/src/shared/ink_touch.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AlarmItem extends StatelessWidget {
  final AlarmData alarmData;
  final Function onTap;

  const AlarmItem({required this.alarmData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkTouch(
      onTap: onTap,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 1.0, color: AppColors.greyBorder),
        ),
        child: Row(
          children: [
            Expanded(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(alarmData.time.format(context).split(" ").first,
                    style: context.textTheme().headline2),
                Padding(
                  padding: const EdgeInsets.only(bottom: 7, left: 2),
                  child: Text(alarmData.time.format(context).split(" ").last,
                      style: context
                          .textTheme()
                          .headline5
                          ?.copyWith(color: AppColors.primary)),
                ),
              ],
            )),
            Expanded(
                child: Text(describeEnum(alarmData.type),
                    textAlign: TextAlign.end,
                    style: context.textTheme().bodyText1))
          ],
        ),
      ),
    );
  }
}
