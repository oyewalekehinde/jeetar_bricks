import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/custom_style.dart';

// ignore: must_be_immutable
class InputText extends StatefulWidget {
  final String? labelText;
  final TextInputType keyboardType;
  final bool isPassword;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final FormFieldSetter<String>? onSaved;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final TextInputAction? textInputAction;
  final String? textPlaceholder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Widget? prefixWidget;
  String? initialValue;
  final bool enabled;
  final TextEditingController? controller;

  InputText({
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.onChanged,
    this.onEditingComplete,
    this.onSaved,
    this.focusNode,
    this.onTap,
    this.textInputAction = TextInputAction.next,
    this.textPlaceholder,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixWidget,
    this.initialValue,
    this.enabled = true,
    this.controller,
  });

  @override
  _InputTextState createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late FocusNode _focusNode;
  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
        duration: Duration(milliseconds: 600),
        // padding: formFieldPadding,
        padding: EdgeInsets.zero,
        child: TextFormField(
          // key: Key(DateTime.now().toString()),
          style: textFieldTextStyle(context),
          initialValue: widget.initialValue,
          controller: widget.controller,
          enabled: widget.enabled,

          focusNode: _focusNode,
          decoration: InputDecoration(
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixWidget,
              prefix: widget.prefixIcon,
              // prefixIconConstraints: BoxConstraints(maxHeight: 40.w),
              labelText: widget.labelText,
              labelStyle: labelStyle(context),
              hintText: widget.textPlaceholder ?? widget.labelText,
              hintStyle: textFieldPlaceholderTextStyle(context),
              isDense: true,
              // filled: true,
              // fillColor: AppColors.textColorSecondaryLight,
              // contentPadding: EdgeInsets.all(height * 0.015),
              focusedBorder: AppStyles.focusedBorder,
              disabledBorder: AppStyles.focusBorder,
              enabledBorder: AppStyles.focusBorder,
              errorBorder: AppStyles.focusErrorBorder,
              focusedErrorBorder: AppStyles.focusErrorBorder,
              errorStyle: errorTextStyle(context)),
          textInputAction: this.widget.textInputAction,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword,
          onSaved: widget.onSaved,
          onEditingComplete: () {
            setState(() {
              FocusScope.of(context).unfocus();
            });
            if (widget.onEditingComplete != null) widget.onEditingComplete!();
          },
          onChanged: widget.onChanged,
          validator: widget.validator,
          onTap: () {
            setState(() {
              FocusScope.of(context).requestFocus(_focusNode);
            });
            if (widget.onTap != null) widget.onTap!();
          },
        ));
  }

  TextStyle? labelStyle(context) {
    return _focusNode.hasFocus
        ? labelTextFieldTextStyle(context)
        : textFieldPlaceholderTextStyle(context);
  }

  labelTextFieldTextStyle(context) => TextStyle(
      fontSize: 14.sp,
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.w600,
      height: 1.4);

  textFieldPlaceholderTextStyle(context) => TextStyle(
      fontSize: 14.sp,
      color: Theme.of(context).hintColor,
      fontWeight: FontWeight.w600,
      height: 1.4);

  errorTextStyle(context) => TextStyle(
      fontSize: 10.sp,
      color: Theme.of(context).colorScheme.error,
      fontWeight: FontWeight.w500,
      height: 1.4);

  textFieldTextStyle(context) => TextStyle(
      fontSize: 14.sp,
      color: Theme.of(context).textTheme.bodyLarge!.color,
      fontWeight: FontWeight.w500,
      height: 1.4);
}
