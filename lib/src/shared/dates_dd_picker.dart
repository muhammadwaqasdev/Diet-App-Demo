import 'package:diet_app/src/base/utils/utils.dart';
import 'package:diet_app/src/shared/app_textfield.dart';
import 'package:flutter/material.dart';

class DatesDDPicker extends StatefulWidget {
  final DateTime? selectedDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  final ValueChanged<DateTime> onChange;
  final bool required;

  DatesDDPicker(
      {Key? key,
      required this.onChange,
      this.selectedDate,
      this.minDate,
      this.maxDate,
      this.required = false})
      : super(key: key);

  @override
  State<DatesDDPicker> createState() => _DatesDDPickerState();
}

class _DatesDDPickerState extends State<DatesDDPicker> {
  late DateTime selectedDate;
  late DateTime minDate;
  late DateTime maxDate;
  TextEditingController _dayCtrl = TextEditingController();
  TextEditingController _monthCtrl = TextEditingController();
  TextEditingController _yearCtrl = TextEditingController();
  final List<String> months = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  void initState() {
    selectedDate = widget.selectedDate ??
        DateTime.now().subtract(Duration(days: (365 * 18)));
    minDate = selectedDate;
    maxDate = DateTime.now();
    super.initState();
  }

  int daysInMonth(DateTime date) => DateTimeRange(
          start: DateTime(date.year, date.month, 1),
          end: DateTime(date.year, date.month + 1))
      .duration
      .inDays;

  _onDaySelect(int day) => setState(() {
        selectedDate = selectedDate.copyWith(day: day);
        _dayCtrl.text = selectedDate.day.toString();
        widget.onChange(selectedDate);
      });

  _onMonthSelect(int month) => setState(() {
        selectedDate = selectedDate.copyWith(month: month);
        _monthCtrl.text = months[selectedDate.month - 1];
        widget.onChange(selectedDate);
      });

  _onYearSelect(int year) => setState(() {
        selectedDate = selectedDate.copyWith(year: year);
        _yearCtrl.text = selectedDate.year.toString();
        widget.onChange(selectedDate);
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          3,
          (index) => ((List<dynamic> params) => Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: AppTextField(
                            readOnly: true,
                            readonlyEffect: false,
                            controller: params.first,
                            placeholder: params[1],
                            defaultValidators: [
                              if (widget.required) DefaultValidators.REQUIRED,
                            ],
                          ),
                        ),
                        params[2],
                      ],
                    ),
                  ))(([
                [
                  _dayCtrl,
                  "Day",
                  _popupButton(
                      onSelect: _onDaySelect,
                      items: List.generate(
                          daysInMonth(selectedDate), (index) => index + 1))
                ],
                [
                  _monthCtrl,
                  "Month",
                  _popupButton(
                      onSelect: _onMonthSelect,
                      items: List.generate(12, (index) => index + 1),
                      valueBuilder: (index) => months[index - 1])
                ],
                [
                  _yearCtrl,
                  "Year",
                  _popupButton(
                      onSelect: _onYearSelect,
                      items: List.generate(
                              DateTime.now().year, (index) => index + 1)
                          .where((element) =>
                              element >= 1900 &&
                              element <= DateTime.now().year - 5)
                          .toList()
                          .reversed
                          .toList())
                ]
              ])[index])),
    );
  }

  Widget _popupButton(
          {required ValueChanged<int> onSelect,
          required List<int> items,
          String Function(int index)? valueBuilder}) =>
      Opacity(
        opacity: 0,
        child: PopupMenuButton<int>(
          padding: EdgeInsets.symmetric(
              horizontal: (MediaQuery.of(context).size.width / 4) / 3),
          onSelected: onSelect,
          itemBuilder: (ctx) => items
              .map((item) => PopupMenuItem<int>(
                    child: Text(
                        valueBuilder != null ? valueBuilder(item) : "$item",
                        style: context
                            .textTheme()
                            .subtitle2
                            ?.copyWith(fontWeight: FontWeight.w300)),
                    value: item,
                  ))
              .toList(),
        ),
      );
}
