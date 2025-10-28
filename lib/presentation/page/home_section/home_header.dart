import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;
import 'package:invoapp/presentation/state/home/home_bloc.dart';
import 'package:invoapp/presentation/widget/language_button.dart';
import 'package:invoapp/presentation/widget/menu_dropdown.dart';

import 'logout_dialog.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.theme,
    required this.currentLanguageCode,
  });

  final app_theme.Theme theme;
  final String currentLanguageCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Consts.sizes.base.xl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          LanguageButton(
            currentLanguageCode: currentLanguageCode,
            onToggle: () {
              context.read<HomeBloc>().add(HomeToggleLocale());
            },
            theme: theme,
          ),
          MenuDropdown(
            theme: theme,
            onAboutTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.l10n.aboutApp),
                  backgroundColor: theme.info,
                ),
              );
            },
            onThemeColorTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(context.l10n.themeColor),
                  backgroundColor: theme.info,
                ),
              );
            },
            onLogoutTap: () {
              showLogoutDialog(context, theme);
            },
          ),
        ],
      ),
    );
  }
}
