import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_starter_app/src/shared/spacing.dart';
import 'package:flutter_starter_app/src/styles/app_colors.dart';
import 'package:flutter_starter_app/src/base/utils/utils.dart';

enum DefaultValidators { REQUIRED, VALID_EMAIL, VALID_PASSWORD }

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? image;
  final String? initialValue;
  final String placeholder;
  final bool ifNoErrorStyle;
  final FormFieldValidator<String>? validator;
  List<DefaultValidators> defaultValidators;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final int? maxLength;
  final int? maxLines;
  final String? hint;
  final dynamic prefixIcon;
  final Widget? suffixIcon;
  final GestureTapCallback? onTap;
  final TextCapitalization? textCapitalization;
  final GestureTapCallback? onSuffixPressed;
  final List<TextInputFormatter> formatters;
  final Color? textColor;
  final bool readonlyEffect;
  final ValueChanged<String>? onChange;

  AppTextField(
      {this.controller,
      this.label,
      this.image,
      this.initialValue,
      this.readOnly = false,
      this.readonlyEffect = true,
      this.keyboardType,
      this.maxLength,
      this.hint,
      this.suffixIcon,
      this.maxLines,
      this.onTap,
      this.textCapitalization,
      this.onSuffixPressed,
      this.placeholder = "Please set 'placeholder' property",
      this.ifNoErrorStyle = false,
      this.validator,
      this.defaultValidators = const [],
      this.textInputAction = TextInputAction.done,
      this.formatters = const [],
      this.prefixIcon,
      this.textColor,
      this.onChange});

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(widget.label!, style: context.textTheme().headline5),
          ),
          VerticalSpacing(5)
        ],
        Opacity(
          opacity: this.widget.readOnly && this.widget.readonlyEffect ? .5 : 1,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: AppColors.greyBorder, width: 1)),
            child: Transform.translate(
              offset: Offset(0, _getPrefixIcon() != null ? -2 : 0),
              child: TextFormField(
                onChanged: widget.onChange,
                enabled: !widget.readOnly,
                inputFormatters: widget.formatters,
                style: context
                    .textTheme()
                    .subtitle2
                    ?.copyWith(fontWeight: FontWeight.w300),
                textCapitalization:
                    widget.textCapitalization ?? TextCapitalization.none,
                cursorColor: Colors.black,
                autofocus: false,
                onTap: widget.onTap ?? null,
                controller: widget.controller,
                readOnly: widget.readOnly,
                keyboardType: widget.keyboardType,
                textInputAction: widget.textInputAction,
                validator: (widget.defaultValidators == null
                    ? widget.validator
                    : (val) {
                        if ((widget.defaultValidators)
                                .contains(DefaultValidators.REQUIRED) &&
                            (val?.isEmpty ?? true)) {
                          return (widget.ifNoErrorStyle)
                              ? ''
                              : "${widget.placeholder} is required";
                        }
                        if ((widget.defaultValidators)
                            .contains(DefaultValidators.VALID_EMAIL)) {
                          if (!RegExp(
                                  r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                              .hasMatch(val ?? '')) {
                            return "${widget.placeholder} is not valid";
                          }
                        }
                        if ((widget.defaultValidators)
                            .contains(DefaultValidators.VALID_PASSWORD)) {
                          if ((val ?? '').length < 6 ||
                              (val ?? '').length > 20) {
                            return '${widget.placeholder} must be betweem 5 and 20 characters';
                          }
                        }
                        if (widget.validator != null) {
                          return widget.validator!(val);
                        }
                        return null;
                      }),
                minLines: 1,
                initialValue: widget.initialValue,
                maxLength: widget.maxLength,
                maxLines: widget.maxLines ?? 1,
                obscureText: (widget.defaultValidators)
                    .contains(DefaultValidators.VALID_PASSWORD),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  suffixIcon: widget.suffixIcon,
                  prefix: _getPrefixIcon(),
                  hintText: widget.hint,
                  hintStyle: context
                      .textTheme()
                      .subtitle2
                      ?.copyWith(fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget? _getPrefixIcon() {
    if (widget.prefixIcon == null) {
      return null;
    } else if (widget.prefixIcon is Widget) {
      return widget.prefixIcon;
    } else if (widget.prefixIcon is String) {
      return Transform.translate(
        offset: Offset(0, 3),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7),
          child: Image.asset(widget.prefixIcon, fit: BoxFit.contain, width: 15),
        ),
      );
    }
  }
}

class CardMonthInputFormatter extends TextInputFormatter {
  static String? validateDate(String value) {
    if (value.isEmpty) {
      return 'asdad';
    }

    int year;
    int month;
    // The value contains a forward slash if the month and year has been
    // entered.
    if (value.contains(new RegExp(r'(\/)'))) {
      var split = value.split(new RegExp(r'(\/)'));
      // The value before the slash is the month while the value to right of
      // it is the year.
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      // Only the month was entered
      month = int.parse(value.substring(0, (value.length)));
      year = -1; // Lets use an invalid year intentionally
    }

    if ((month < 1) || (month > 12)) {
      // A valid month is between 1 (January) and 12 (December)
      return '';
    }

    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      // We are assuming a valid year should be between 1 and 2099.
      // Note that, it's valid doesn't mean that it has not expired.
      return '';
    }

    if (!hasDateExpired(month, year)) {
      return "";
    }
    return null;
  }

  /// Convert the two-digit year to four-digit year if necessary
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return !(month == null || year == null) && isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is less than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently, is greater than card's
    // year
    return fourDigitsYear < now.year;
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var newText = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      buffer.write(newText[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
        buffer.write('/');
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 0) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}

// if (widget.formatters == CreditCardFormatters.cardMask)
//                 MaskedTextInputFormatter(
//                   mask: 'xxxx-xxxx-xxxx-xxxx',
//                   separator: '-',
//                 ),
//               if (widget.formatters == CreditCardFormatters.expDateMask) ...[
//                 FilteringTextInputFormatter.digitsOnly,
//                 LengthLimitingTextInputFormatter(4),
//                 CardMonthInputFormatter(),
//               ],
//               if (widget.formatters == CreditCardFormatters.cvvMask) ...[
//                 FilteringTextInputFormatter.digitsOnly,
//                 LengthLimitingTextInputFormatter(3)
//               ]
