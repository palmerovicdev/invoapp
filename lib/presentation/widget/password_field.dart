import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoapp/core/localization/app_locale.dart';

import '../../core/util/feedback.dart';
import '../state/home/home_bloc.dart';

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
    final homeState = context.watch<HomeBloc>().state;
    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: homeState.theme.primary,
          selectionColor: homeState.theme.primary.withOpacity(Consts.ui.opacities.hover),
          selectionHandleColor: homeState.theme.primary,
        ),
      ),
      child: TextFormField(
        controller: widget.controller,
        enabled: widget.enabled,
        obscureText: _obscurePassword,
        obscuringCharacter: '₿',
        style: TextStyle(
          color: _obscurePassword ? homeState.theme.primary : homeState.theme.text,
          letterSpacing: _obscurePassword ? Consts.sizes.base.xxs : Consts.sizes.base.none,
        ),
        cursorColor: homeState.theme.text,
        decoration: InputDecoration(
          labelText: context.l10n.password,
          hintText: context.l10n.password,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.circle_outlined : Icons.circle,
              color: _obscurePassword ? homeState.theme.primary : homeState.theme.textMuted,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          filled: true,
          fillColor: homeState.theme.bgLight,
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
            borderSide: BorderSide(color: homeState.theme.danger, width: Consts.sizes.base.xxs),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: Consts.radius.containers.xxl,
            borderSide: BorderSide(color: homeState.theme.danger, width: Consts.sizes.base.xxs),
          ),
          labelStyle: TextStyle(color: homeState.theme.textMuted),
          hintStyle: TextStyle(color: homeState.theme.textMuted),
          focusColor: homeState.theme.primary,
          hoverColor: homeState.theme.primary,
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
