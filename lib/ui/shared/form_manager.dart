import 'package:flutter/material.dart';
import 'package:lightsonheights/core/constants/app_color.dart';
import 'package:lightsonheights/ui/shared/sizer_manager.dart';

enum TextfieldType {
  normal,
  password,
  email,
  phoneNumber,
  bvn,
  code,
  nuban,
  passcode,
  currency,
}

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool obscureText;
  final bool showQuote;
  final int? maxLength, maxLine;
  final double? labelSpacing;
  final double? borderRadius;
  final double suffixPadding, prefixPadding;
  final String? hintText, labelText, prefixText;
  final Color? labelTextColor, fillColor, hintTextColor, primaryColor;
  final Widget? suffixIcon, labelWidget, prefixIcon;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final TextStyle? textStyle, hintTextStyle, prefixStyle, labelStyle;
  final BoxConstraints? suffixIconConstraints, prefixIconConstraints;
  final bool readOnly,
      isPasswordTextField,
      centerText,
      enableSuggestions,
      autocorrect,
      notValidated,
      isDense;
  final TextfieldType textfieldType;
  final Function()? onTap;
  final Function(String)? onChanged;
  final bool noFocusedBorder;
  final EdgeInsetsGeometry? contentPadding;
  const CustomTextField(
      {super.key,
      this.controller,
      this.labelSpacing,
      this.suffixPadding = 20,
      this.prefixPadding = 10,
      this.contentPadding,
      this.focusNode,
      this.borderRadius,
      this.nextFocus,
      this.onChanged,
      this.onFieldSubmitted,
      this.textStyle,
      this.hintTextStyle,
      this.prefixStyle,
      this.onTap,
      this.validator,
      this.hintText,
      this.labelText,
      this.labelWidget,
      this.suffixIcon,
      this.prefixIcon,
      this.prefixText,
      this.maxLength,
      this.maxLine = 1,
      this.labelStyle,
      this.noFocusedBorder = false,
      this.showQuote = false,
      this.fillColor,
      this.labelTextColor = AppColor.black,
      this.hintTextColor = AppColor.grey200,
      this.primaryColor = AppColor.brandBlue,
      this.readOnly = false,
      this.isDense = true,
      this.obscureText = false,
      this.centerText = false,
      this.autocorrect = false,
      this.enableSuggestions = false,
      this.isPasswordTextField = false,
      this.keyboardType,
      this.textInputAction = TextInputAction.next,
      this.textCapitalization = TextCapitalization.sentences,
      this.textfieldType = TextfieldType.normal,
      this.suffixIconConstraints,
      this.notValidated = false,
      this.prefixIconConstraints});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    Sizer.init(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: Sizer.width(0)),
          child: (widget.labelText != null)
              ? Text(widget.labelText!,
                  style: widget.labelStyle ??
                      TextStyle(
                        color: widget.labelTextColor,
                        fontSize: Sizer.text(14),
                        fontWeight: FontWeight.w400,
                      ))
              : (widget.labelWidget != null)
                  ? widget.labelWidget!
                  : const SizedBox(),
        ),
        if ((widget.labelWidget != null) || (widget.labelText != null))
          SizedBox(
            height: Sizer.height(widget.labelSpacing ?? 8),
          ),
        Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.center,
          children: [
            SizedBox(
              //TODO: confirm whether to enforce height height: Sizer.height(46),
              child: TextFormField(
                autovalidateMode: widget.validator != null
                    ? AutovalidateMode.onUserInteraction
                    : null,
                autocorrect: widget.autocorrect,
                enableSuggestions: widget.enableSuggestions,
                maxLength: widget.maxLength,
                maxLines: widget.maxLine,
                onTap: widget.onTap,
                readOnly: widget.readOnly,
                controller: widget.controller,
                focusNode: widget.focusNode,
                textInputAction: widget.textInputAction,
                textCapitalization: widget.textCapitalization,
                cursorColor: widget.primaryColor,
                obscureText: widget.isPasswordTextField
                    ? _obscureText
                    : widget.obscureText,
                keyboardType: widget.keyboardType ??
                    (widget.textfieldType == TextfieldType.currency
                        ? const TextInputType.numberWithOptions(decimal: true)
                        : (widget.textfieldType == TextfieldType.bvn ||
                                widget.textfieldType == TextfieldType.code ||
                                widget.textfieldType == TextfieldType.nuban ||
                                widget.textfieldType ==
                                    TextfieldType.passcode ||
                                widget.textfieldType ==
                                    TextfieldType.phoneNumber)
                            ? TextInputType.number
                            : (widget.textfieldType == TextfieldType.email)
                                ? TextInputType.emailAddress
                                : TextInputType.text),
                onChanged: widget.onChanged,
                buildCounter: (BuildContext context,
                        {int? currentLength,
                        int? maxLength,
                        bool? isFocused}) =>
                    null,
                textAlign:
                    widget.centerText ? TextAlign.center : TextAlign.start,
                style: widget.textStyle,
                decoration: InputDecoration(
                  // fillColor: widget.fillColor,
                  // filled: true,
                  isDense: widget.isDense,
                  hintText: widget.hintText,
                  hintStyle: widget.hintTextStyle
                      ?.copyWith(color: widget.hintTextColor),

                  suffixIcon: Padding(
                    padding: EdgeInsetsDirectional.only(
                        end: Sizer.width(widget.suffixPadding)),
                    child: widget.notValidated
                        ? Icon(
                            Icons.info,
                            size: Sizer.radius(20),
                            color: AppColor.red,
                          )
                        : widget.isPasswordTextField
                            ? InkWell(
                                onTap: (() => setState(() {
                                      _obscureText = !_obscureText;
                                    })),
                                child: Icon(
                                  _obscureText
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: Sizer.radius(18),
                                  color: widget.hintTextColor,
                                ))
                            : widget.suffixIcon,
                  ),
                  prefixIcon: widget.prefixIcon ??
                      (widget.prefixText != null
                          ? Padding(
                              padding: EdgeInsetsDirectional.only(
                                  start: Sizer.width(widget.prefixPadding)),
                              child: Text(
                                widget.prefixText!,
                                style: widget.prefixStyle?.copyWith(height: 1),
                              ))
                          : null),
                  prefixIconConstraints: widget.prefixIconConstraints ??
                      BoxConstraints(minWidth: Sizer.width(50), minHeight: 0),
                  suffixIconConstraints: widget.suffixIconConstraints,
                  //  prefixText: widget.prefixText,
                  prefixStyle: widget.prefixStyle,
                  contentPadding: widget.contentPadding ??
                      EdgeInsets.only(left: Sizer.width(20)),
                  border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColor.lightGrey, width: 0.5),
                    borderRadius: BorderRadius.circular(
                        Sizer.radius(widget.borderRadius ?? 40)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.lightGrey,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(
                        Sizer.radius(widget.borderRadius ?? 40)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: widget.noFocusedBorder
                        ? BorderSide.none
                        : BorderSide(
                            color: widget.primaryColor ?? AppColor.brandBlue,
                          ),
                    borderRadius: BorderRadius.circular(
                        Sizer.radius(widget.borderRadius ?? 40)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.red,
                    ),
                    borderRadius: BorderRadius.circular(
                        Sizer.radius(widget.borderRadius ?? 40)),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColor.red,
                    ),
                    borderRadius: BorderRadius.circular(
                        Sizer.radius(widget.borderRadius ?? 40)),
                  ),
                  counter: null,
                ),
                onFieldSubmitted: (text) => widget.nextFocus != null
                    ? FocusScope.of(context).requestFocus(widget.nextFocus)
                    : (widget.onFieldSubmitted != null
                        ? widget.onFieldSubmitted!(text)
                        : null),
                validator: widget.validator,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
