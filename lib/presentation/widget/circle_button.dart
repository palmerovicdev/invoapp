import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;

class CircleButton extends StatelessWidget {
  const CircleButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.enabled,
    this.size = 32,
  });

  final IconData icon;
  final VoidCallback onTap;
  final bool enabled;
  final double size;

  @override
  Widget build(BuildContext context) {
    var theme = app_theme.Theme.themes[app_theme.Theme.currentThemeIndex];
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Container(
        width: size + Consts.sizes.base.mdl,
        height: size + Consts.sizes.base.mdl,
        decoration: BoxDecoration(
          color: enabled ? theme.bg : theme.bgLight.withOpacity(Consts.ui.opacities.disabled),
          shape: BoxShape.circle,
          border: Border.all(
            color: enabled ? theme.borderMuted : theme.borderMuted.withOpacity(Consts.ui.opacities.disabled),
            width: 0.1,
          ),
        ),
        child: Icon(
          icon,
          color: enabled ? theme.text : theme.textMuted,
          size: size,
        ),
      ),
    );
  }
}
