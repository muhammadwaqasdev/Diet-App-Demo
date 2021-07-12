import 'package:flutter/material.dart';
import 'package:flutter_starter_app/src/base/utils/utils.dart';
import 'package:flutter_starter_app/src/styles/app_colors.dart';
import 'package:intl/intl.dart';

class AlarmItem extends StatelessWidget {
  final DateTime time;
  final String label;

  const AlarmItem({required this.time, this.label = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(width: 1.0, color: AppColors.greyBorder),
      ),
      child: Row(
        children: [
          Expanded(
              child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(DateFormat("h : mm").format(time),
                  style: context.textTheme().headline2),
              Padding(
                padding: const EdgeInsets.only(bottom: 7, left: 2),
                child: Text(DateFormat("a").format(time),
                    style: context
                        .textTheme()
                        .headline5
                        ?.copyWith(color: AppColors.primary)),
              ),
            ],
          )),
          Spacer(),
          Text(label, style: context.textTheme().bodyText1)
        ],
      ),
    );
  }
}
