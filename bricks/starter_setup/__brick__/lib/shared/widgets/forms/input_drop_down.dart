import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/colors.dart';

class InputDropDown extends StatefulWidget {
  final ValueChanged<String?>? onChanged;
  final String? selectedValue;
  final List<String> items;
  final FocusNode? focusNode;
  final String labelText;
  final Widget? prefixIcon;
  final String? textPlaceholder;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final String? headerText;
  const InputDropDown({
    Key? key,
    this.onChanged,
    this.selectedValue,
    required this.items,
    required this.labelText,
    this.textPlaceholder,
    this.focusNode,
    this.validator,
    this.headerText,
    this.onSaved,
    this.prefixIcon,
  }) : super(key: key);

  @override
  State<InputDropDown> createState() => _InputDropDownState();
}

class _InputDropDownState extends State<InputDropDown> {
  Color borderColor = Colors.transparent;
  bool isError = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FocusScope(
          child: Focus(
            onFocusChange: (focus) {
              //Called when ever focus changes
              setState(() {
                getBorderColor(focus);
                // if (widget.validator != null &&
                //     widget.validator!
                //         .call(_controller.text)
                //         .toString()
                //         .isNotEmpty) {
                //   isError = true;
                //   errorString = widget.validator!(_controller.text);
                // } else {
                //   isError = false;
                // errorString =
                //     widget.validator(widget.controller.text);
                // }
              });
            },
            child: Container(
              height: 56.h,
              padding: EdgeInsets.only(
                  left: widget.prefixIcon == null ? 24.w : 0, right: 24.w),
              decoration: BoxDecoration(
                color: AppColors.inputDropDownColor,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  width: 1,
                  style: BorderStyle.solid,
                  color: borderColor,
                ),
              ),
              child: DropdownButtonFormField(
                icon: SizedBox(),
                // Padding(
                //   padding: EdgeInsets.only(bottom: 0.w),
                //   child: const Icon(Icons.keyboard_arrow_down_sharp),
                // ),
                value: widget.selectedValue,
                items: widget.items.map((value) {
                  return DropdownMenuItem<String>(
                      value: value, child: Text(value));
                }).toList(),
                onChanged: widget.onChanged,
                style: textFieldTextStyle(context),
                decoration: InputDecoration(
                  // hintText: widget.labelText,
                  labelText: widget.labelText,
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: const Icon(Icons.keyboard_arrow_down),
                  hintStyle: TextStyle(
                    color: AppColors.inputDropDownLabelColor.withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14.sp,
                    height: 1.26,
                  ),
                  labelStyle: TextStyle(
                    color: AppColors.inputDropDownLabelColor,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 14.sp,
                    height: 1.26,
                  ),
                  floatingLabelStyle: TextStyle(
                    color: AppColors.inputDropDownLabelColor,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 12.sp,
                    height: 1.5,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                // InputDecoration(
                //     labelText: labelText,
                //     prefixIcon: prefixIcon,
                //     prefixIconConstraints: BoxConstraints(maxHeight: 40.w),
                //     labelStyle: labelStyle(context),
                //     hintText: textPlaceholder ?? labelText,
                //     hintStyle: textFieldPlaceholderTextStyle(context),
                //     isDense: true,
                //     filled: false,
                //     // fillColor: AppColors.textColorSecondaryLight,
                //     // contentPadding: EdgeInsets.all(height * 0.015),
                //     focusedBorder: AppStyles.focusedBorder,
                //     disabledBorder: AppStyles.focusBorder,
                //     enabledBorder: AppStyles.focusBorder,
                //     errorBorder: AppStyles.focusedBorder,
                //     focusedErrorBorder: AppStyles.focusedBorder,
                //     errorStyle: errorTextStyle(context)),
                validator: widget.validator,
                onSaved: widget.onSaved,
              ),
            ),
          ),
        ),
      ],
    );
  }

  getBorderColor(isFocus) {
    borderColor = isError
        ? AppColors.errorColor
        : isFocus
            ? Colors.black
            : Colors.transparent;
  }

  TextStyle? labelStyle(context) {
    if (widget.focusNode != null) {
      return widget.focusNode!.hasFocus
          ? labelTextFieldTextStyle(context)
          : textFieldPlaceholderTextStyle(context);
    }
    return textFieldPlaceholderTextStyle(context);
  }

  labelTextFieldTextStyle(context) => TextStyle(
        color: AppColors.inputDropDownLabelColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: 12.sp,
        height: 1.5,
      );

  // TextStyle(
  textFieldTextStyle(context) => TextStyle(
      fontSize: 14.sp,
      color: AppColors.inputDropDownLabelColor,
      fontWeight: FontWeight.w600,
      height: 1.4);

  textFieldPlaceholderTextStyle(context) => TextStyle(
      fontSize: 14.sp,
      color: AppColors.inputDropDownColor,
      fontWeight: FontWeight.w400,
      height: 1.4);

  errorTextStyle(context) => TextStyle(
      fontSize: 14.sp,
      color: Theme.of(context).colorScheme.error,
      fontWeight: FontWeight.w500,
      height: 1.4);
}
