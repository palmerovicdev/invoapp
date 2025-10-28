import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as thm;

import '../../core/util/feedback.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.controller,
    required this.enabled,
  });

  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = thm.Theme.themes[thm.Theme.currentThemeIndex];
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: theme.primary,
          selectionColor: theme.primary.withOpacity(Consts.ui.opacities.hover),
          selectionHandleColor: theme.primary,
        ),
      ),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: theme.text),
        cursorColor: theme.text,
        decoration: InputDecoration(
          labelText: context.l10n.email,
          hintText: context.l10n.email,
          prefixIcon: Icon(
            Icons.email_outlined,
            color: theme.primary,
          ),
          filled: true,
          fillColor: theme.bgLight,
          border: OutlineInputBorder(
            borderRadius: Consts.radius.containers.xxl,
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: Consts.radius.containers.xxl,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: Consts.radius.containers.xxl,
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: Consts.radius.containers.xxl,
            borderSide: BorderSide(color: theme.danger, width: Consts.sizes.base.xxs),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: Consts.radius.containers.xxl,
            borderSide: BorderSide(color: theme.danger, width: Consts.sizes.base.xxs),
          ),
          labelStyle: TextStyle(color: theme.textMuted),
          hintStyle: TextStyle(color: theme.textMuted),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            error(null);
            return context.l10n.emailRequired;
          }
          final emailRegex = RegExp(
            r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
          );
          if (!emailRegex.hasMatch(value.trim())) {
            error(null);
            return context.l10n.emailInvalid;
          }
          return null;
        },
      ),
    );
  }
}
