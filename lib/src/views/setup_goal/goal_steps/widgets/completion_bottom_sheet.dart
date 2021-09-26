import 'package:diet_app/generated/images.asset.dart';
import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/services/local/navigation_service.dart';
import 'package:diet_app/src/shared/app_elevated_button.dart';
import 'package:flutter/material.dart';

class CompletionBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
          border: Border(left: BorderSide(color: Colors.red, width: 5))),
      padding: EdgeInsets.only(
          top: 10,
          bottom: MediaQuery.of(context).padding.bottom > 0
              ? MediaQuery.of(context).padding.bottom
              : 10,
          left: 10,
          right: 10),
      child: Column(
        children: [
          Text("Goal Setup Complete!", style: context.textTheme().headline3),
          Text(
            "You can now continue on your dashboard. Tao continute to move forward!",
            style: context.textTheme().subtitle2,
            textAlign: TextAlign.center,
          ),
          Spacer(),
          Icon(Icons.check_circle_outline, size: 200),
          Row(
            children: [
              Expanded(
                child: AppElevatedButton.withIcon(
                  child: "CONTINUE",
                  onTap: NavService.dashboard,
                  icon: Image.asset(Images.icRightArrow),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
