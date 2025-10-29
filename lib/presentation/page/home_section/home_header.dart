import 'package:animate_do/animate_do.dart';
import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;
import 'package:invoapp/core/util/feedback.dart';
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
          ZoomIn(
            child: LanguageButton(
              currentLanguageCode: currentLanguageCode,
              onToggle: () {
                click(null);
                context.read<HomeBloc>().add(HomeToggleLocale());
              },
              theme: theme,
            ),
          ),
          ZoomIn(
            delay: Consts.durations.base.sm,
            child: MenuDropdown(
              theme: theme,
              onAboutTap: () {
                click(null);
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: theme.bg,
                      title: Row(
                        children: [
                          Icon(
                            Icons.currency_bitcoin_sharp,
                            size: 48,
                            color: theme.primary,
                          ),
                          Consts.spacing.gapHorizontal.md,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'InvoApp',
                                style: TextStyle(color: theme.primary),
                              ),
                              Text(
                                '1.0.0',
                                style: TextStyle(
                                  color: theme.primary,
                                  fontSize: Consts.fontSizes.device.mobileCompact.bodySmall,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            context.l10n.aboutAppDescription,
                            style: TextStyle(color: theme.primary),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      actions: [
                        FilledButton(
                          onPressed: () => Navigator.pop(context),
                          style: FilledButton.styleFrom(
                            backgroundColor: theme.bgLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: Consts.radius.containers.md,
                            ),
                          ),
                          child: Text(
                            context.l10n.close,
                            style: TextStyle(color: theme.primary),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              onLogoutTap: () {
                showLogoutDialog(context, theme);
              },
            ),
          ),
        ],
      ),
    );
  }
}
