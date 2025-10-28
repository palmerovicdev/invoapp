import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;
import 'package:invoapp/core/util/extensions.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.searchController,
    this.showSearch = true,
    this.onNotShow,
  });

  final TextEditingController? searchController;
  final bool showSearch;
  final VoidCallback? onNotShow;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Consts.durations.base.md,
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = app_theme.Theme.themes[app_theme.Theme.currentThemeIndex];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Consts.spacing.base.xl),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          var width = (context.width - 60) * _animationController.value + 60;
          var responsiveFontSize = context.getResponsiveFontSize(
            smallest: Consts.fontSizes.device.mobile.bodySmall,
          );
          return Theme(
            data: Theme.of(context).copyWith(
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: theme.primary,
              ),
            ),
            child: SizedBox(
              height: Consts.sizes.base.giant,
              width: width,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      focusNode: _focusNode,
                      controller: widget.searchController,
                      style: TextStyle(
                        color: theme.textMuted,
                        fontSize: responsiveFontSize,
                      ),
                      cursorHeight: responsiveFontSize + 2,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: theme.bgLight,
                        contentPadding: EdgeInsets.only(left: Consts.spacing.base.xl),
                        hintText: 'Buscar...',
                        hintStyle: TextStyle(color: theme.textMuted.withOpacity(0.6)),
                        border: OutlineInputBorder(
                          borderRadius: Consts.radius.containers.xxl,
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (value) {
                        // TODO 10/28/25 palmerodev : implement submit
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.searchController?.clear();
                      });
                      _focusNode.unfocus();
                      _animationController.reverse(from: 1).then((value) {
                        widget.onNotShow?.call();
                      });
                    },
                    icon: Icon(Icons.close, color: theme.primary, size: Consts.sizes.icons.sm),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
