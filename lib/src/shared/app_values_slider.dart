import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/src/shared/spacing.dart';
import 'package:diet_app/src/styles/app_colors.dart';
import 'package:diet_app/src/base/utils/utils.dart';

class AppValuesSlider extends StatelessWidget {
  final List<double> values;
  final String label;
  final String subLabel;
  final bool shouldRound;
  final ValueChanged<double> onChanged;
  final double value;

  const AppValuesSlider(
      {required this.label,
      required this.value,
      required this.onChanged,
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
            Transform.scale(
              scale: 1.1,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 7,
                    inactiveTrackColor: Colors.black12,
                    activeTrackColor: AppColors.activeLightGreen,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
                  ),
                  child: Slider(
                    min: values.first,
                    max: values.last,
                    value: value,
                    onChanged: onChanged,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
