import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr/core/assets/app_icons.dart';
import 'package:hr/core/widgets/text_form_field/columned_text_form_field.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DatePicker extends StatelessWidget {
  DatePicker({
    super.key,
    required this.datePickerController,
    required this.datePickerLabel,
    required this.validation,
    this.datePickerHint,
    this.labelColor = Colors.black,
    this.iconColor = Colors.black,
    this.dateColor = Colors.white,
  });

  TextEditingController datePickerController;
  final String datePickerLabel;
  final String? validation;
  final String? datePickerHint;
  final Color labelColor;
  final Color iconColor;
  final Color dateColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          () => showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.parse('2025-12-31'),
          ).then(
            (value) => //DateFormat.yMMMMd().format(value!)
                datePickerController.text = DateFormat(
                  'yyyy-MM-dd',
                ).format(value!),
          ),
      child: ColumnedTextFormField(
        controller: datePickerController,
        inputType: TextInputType.datetime,
        title: datePickerLabel,
        titleColor: labelColor,
        hint: datePickerHint,
        hintColor: dateColor,
        enabled: false,
        maxLines: 1,
        textFieldTextColor: dateColor,
        suffixIcon: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(AppIcons.calenderIc),
        ),
        validate: (value) => value == null || value.isEmpty ? validation : null,
      ),
    );
  }
}
