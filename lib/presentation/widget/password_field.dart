import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as thm;

import '../../core/util/feedback.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    required this.enabled,
  });

  final TextEditingController controller;
  final bool enabled;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscurePassword = true;

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
        controller: widget.controller,
        enabled: widget.enabled,
        obscureText: _obscurePassword,
        obscuringCharacter: '₿',
        style: TextStyle(
          color: _obscurePassword ? theme.primary : theme.text,
          letterSpacing: _obscurePassword ? Consts.sizes.base.xxs : Consts.sizes.base.none,
        ),
        cursorColor: theme.text,
        decoration: InputDecoration(
          labelText: context.l10n.password,
          hintText: context.l10n.password,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.circle_outlined : Icons.circle,
              color: _obscurePassword ? theme.primary : theme.textMuted,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
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
          focusColor: theme.primary,
          hoverColor: theme.primary,
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            error(null);
            return context.l10n.passwordRequired;
          }
          if (value.length < 6) {
            error(null);
            return context.l10n.passwordTooShort;
          }
          return null;
        },
      ),
    );
  }
}
