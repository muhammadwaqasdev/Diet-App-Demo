import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_app/src/shared/spacing.dart';
import 'package:flutter_starter_app/src/styles/app_colors.dart';
import 'package:flutter_starter_app/src/base/utils/utils.dart';

class AppValuesSlider extends StatelessWidget {
  final List<double> values;
  final String label;
  final String subLabel;
  final bool shouldRound;

  const AppValuesSlider(
      {required this.label,
      this.subLabel = "",
      required this.values,
      this.shouldRound = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 15),
          child: Row(
            children: [
              Expanded(
                  child: Text(label, style: context.textTheme().headline5)),
              if (subLabel.isNotEmpty)
                Text(subLabel, style: context.textTheme().headline5)
            ],
          ),
        ),
        VerticalSpacing(5),
        Stack(
          children: [
            Positioned(
              top: 5,
              left: 2,
              child: SizedBox(
                width: context.screenSize().width.percent(84),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: values
                        .map((sliderValue) => Text(
                            '${shouldRound ? sliderValue.round() : sliderValue}',
                            style: context
                                .textTheme()
                                .headline6
                                ?.copyWith(color: AppColors.greyBgDarkest)))
                        .toList(),
                  ),
                ),
              ),
            ),
            FlutterSlider(
              min: values.first,
              max: values.last,
              values: values,
              selectByTap: true,
              handler: FlutterSliderHandler(
                decoration: BoxDecoration(),
                child: Material(
                  type: MaterialType.canvas,
                  elevation: 3,
                  borderRadius: BorderRadius.circular(16 / 2),
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16 / 2),
                      color: AppColors.primary,
                      border: Border.all(width: 2.0, color: AppColors.primary),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x29000000),
                          offset: Offset(0, 3),
                          blurRadius: 9,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              trackBar: FlutterSliderTrackBar(
                activeTrackBarDraggable: true,
                activeTrackBarHeight: 10,
                inactiveTrackBarHeight: 10,
                inactiveTrackBar: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black12,
                ),
                activeTrackBar: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.activeLightGreen),
              ),
            )
          ],
        ),
      ],
    );
  }
}
