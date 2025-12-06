import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_styles.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ReusableTextField extends HookWidget {
  final TextEditingController controller;
  final String hintText;
  final int? maxLines;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final bool isPassword;
  final double? radius;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final String? prefixText;
  final VoidCallback? onTapPrefix;
  final bool filled;
  final bool isBorder;
  final bool isHeading;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const ReusableTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.isHeading = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.prefixIcon,
    this.isPassword = false,
    this.filled = true,
    this.isBorder = true,
    this.radius,
    this.onChanged,
    this.focusNode,
    this.prefixText,
    this.onTapPrefix,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    // Use external focusNode or create internal one safely
    final localFocusNode = useFocusNode();
    final currentFocusNode = focusNode ?? localFocusNode;

    // Track focus changes using hooks
    final isFocused = useState(false);

    useEffect(() {
      void listener() {
        isFocused.value = currentFocusNode.hasFocus;
      }

      currentFocusNode.addListener(listener);
      return () => currentFocusNode.removeListener(listener);
    }, [currentFocusNode]);

    return TextFormField(
      onChanged: onChanged,
      focusNode: currentFocusNode,
      obscureText: isPassword,
      validator: validator,
      maxLines: maxLines,
      controller: controller,
      style: isHeading
          ? AppStyles.headingPrimary(context: context)
          : AppStyles.descriptionPrimary(context: context),
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textAlignVertical: TextAlignVertical.center,
      minLines: 1,
      decoration: !isBorder
          ? InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          color: Colors.black.withOpacity(0.8),
        ),
      )
          : InputDecoration(
        prefixIcon: prefixText != null || prefixIcon != null
            ? InkWell(
          onTap: onTapPrefix,
          child: prefixText != null
              ? Padding(
            padding: const EdgeInsets.only(top: 12, left: 18),
            child: Text(
              prefixText!,
              style: AppStyles.headingPrimary(
                context: context,
              ),
            ),
          )
              : prefixIcon == null
              ? null
              : Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Icon(
              prefixIcon,
              color: isFocused.value
                  ? theme.primary
                  : theme.onSurface.withOpacity(0.8),
              size: 25,
            ),
          ),
        )
            : null,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: 'Poppins',
          color: isFocused.value
              ? theme.primary
              : theme.onSurface.withValues(alpha: 0.8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius ?? 15),
          borderSide: BorderSide(
            color:
            isFocused.value ? theme.primary : theme.onSurface,
            width: 1.5,
          ),
        ),
        fillColor: theme.surface,
        filled: filled,
      ),
    );
  }
}
