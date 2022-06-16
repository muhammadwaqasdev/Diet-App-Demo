import 'package:diet_app/src/styles/app_colors.dart';
import 'package:flutter/material.dart';

typedef ChipListLabelBuilder = String Function(int index);
typedef ChipListSelectedBuilder = bool Function(int index);

class ChipList extends StatelessWidget {
  final double horizontalPadding;
  final int itemsCount;
  final ChipListLabelBuilder labelBuilder;
  final ValueChanged<int> onTapChip;
  final int? selectedIndex;
  final Color? selectedColor;
  final Widget? header;
  final GestureTapCallback? onHeaderTap;
  final List<int> fullFilledIndexes;

  ChipList(
      {required this.horizontalPadding,
      required this.itemsCount,
      required this.labelBuilder,
      required this.onTapChip,
      this.selectedIndex,
      this.selectedColor,
      this.header,
      this.onHeaderTap,
      this.fullFilledIndexes = const []});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 48,
        child: ListView.builder(
          padding: EdgeInsets.only(left: horizontalPadding),
          scrollDirection: Axis.horizontal,
          itemCount: itemsCount + (header != null ? 1 : 0),
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.only(right: 7),
            child: GestureDetector(
              onTap: () => header != null && onHeaderTap != null && index == 0
                  ? onHeaderTap!()
                  : onTapChip(index - (header != null ? 1 : 0)),
              child: header != null && index == 0
                  ? header
                  : Chip(
                      padding:
                          EdgeInsets.symmetric(vertical: 7, horizontal: 18),
                      label: AnimatedDefaultTextStyle(
                        duration: Duration(milliseconds: 250),
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: fullFilledIndexes.contains(index)
                                ? Colors.white
                                : Colors.black),
                        child: Text(
                          labelBuilder(index - (header != null ? 1 : 0)),
                        ),
                      ),
                      backgroundColor: fullFilledIndexes.contains(index)
                          ? AppColors.primary
                          : selectedIndex != null &&
                                  selectedIndex ==
                                      index - (header != null ? 1 : 0)
                              ? (selectedColor != null
                                  ? selectedColor
                                  : AppColors.activeLightGreen)
                              : AppColors.greyBorder),
            ),
          ),
        ),
      );
}
