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
        style: TextStyle(
          color: theme.primary,
        ),
        cursorColor: theme.primary,
        decoration: InputDecoration(
          hintText: context.l10n.email,
          filled: true,
          fillColor: theme.bgLight,
          errorStyle: TextStyle(color: theme.danger),
          contentPadding: EdgeInsets.symmetric(
            vertical: Consts.sizes.base.lgx,
            horizontal: Consts.sizes.base.xl,
          ),
          border: OutlineInputBorder(
            borderRadius: Consts.radius.containers.xxxl,
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: Consts.radius.containers.xxxl,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: Consts.radius.containers.xxxl,
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: Consts.radius.containers.xxxl,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: Consts.radius.containers.xxxl,
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
