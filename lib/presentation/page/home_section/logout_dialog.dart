import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;

import '../../state/login/login_bloc.dart';

void showLogoutDialog(BuildContext context, app_theme.Theme theme) {
  showDialog(
    context: context,
    builder: (dialogContext) => LogoutDialog(theme: theme),
  );
}

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({
    super.key,
    required this.theme,
  });

  final app_theme.Theme theme;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: theme.bg,
      shape: Consts.radius.shapes.xxl,
      child: Padding(
        padding: Consts.spacing.padding.xxl,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.l10n.doYouWantToLogout,
              style: TextStyle(
                fontSize: context.getResponsiveFontSize(
                  smallest: Consts.fontSizes.device.mobile.body,
                ),
                fontWeight: FontWeight.w600,
                color: theme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            Consts.spacing.gap.xxl,
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.bgLight,
                      foregroundColor: theme.primary,
                      padding: EdgeInsets.symmetric(
                        vertical: Consts.spacing.padding.sm.vertical,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: Consts.radius.containers.lg,
                        side: BorderSide(
                          color: theme.borderMuted.withOpacity(
                            Consts.ui.opacities.disabled,
                          ),
                          width: Consts.sizes.base.xxs,
                        ),
                      ),
                    ),
                    child: Text(
                      context.l10n.cancel,
                      style: TextStyle(color: theme.primary),
                    ),
                  ),
                ),
                Consts.spacing.gapHorizontal.md,
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<LoginBloc>().add(LoginLogout());
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.danger.withOpacity(
                        Consts.ui.opacities.disabled,
                      ),
                      foregroundColor: theme.danger,
                      padding: EdgeInsets.symmetric(
                        vertical: Consts.spacing.padding.sm.vertical,
                      ),
                      shape: Consts.radius.shapes.lg,
                    ),
                    child: Text(context.l10n.logout),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
