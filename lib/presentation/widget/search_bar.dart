import 'dart:async';

import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoapp/core/localization/app_locale.dart';
import 'package:invoapp/core/theme/theme.dart' as app_theme;
import 'package:invoapp/core/util/extensions.dart';
import 'package:invoapp/core/util/feedback.dart';

import '../state/home/home_bloc.dart';

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
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Consts.durations.base.md,
    )..forward();

    widget.searchController?.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    widget.searchController?.removeListener(_onSearchChanged);
    _animationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    if (widget.searchController?.text == null || (widget.searchController?.text.isEmpty ?? true)) return;
    _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        final query = widget.searchController?.text ?? '';
        context.read<HomeBloc>().add(
          HomeLoadInvoices(
            searchQuery: query.isEmpty ? null : query,
            page: 1,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = app_theme.Theme.themes[app_theme.Theme.currentThemeIndex];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Consts.spacing.base.xl),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          var width = (context.width - 120) * _animationController.value + 120;
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
                        contentPadding: EdgeInsets.only(
                          left: Consts.spacing.base.xl,
                        ),
                        hintText: width > 130 ? context.i18n('search') : '',
                        hintStyle: TextStyle(
                          color: theme.textMuted.withOpacity(0.6),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: Consts.radius.containers.xxl,
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (value) {
                        _debounceTimer?.cancel();
                        context.read<HomeBloc>().add(
                          HomeLoadInvoices(
                            searchQuery: value.isEmpty ? null : value,
                            page: 1,
                          ),
                        );
                      },
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      click(null);
                      _debounceTimer?.cancel();
                      setState(() {
                        widget.searchController?.clear();
                      });
                      _focusNode.unfocus();
                      _animationController.reverse(from: 1).then((value) {
                        widget.onNotShow?.call();
                        context.read<HomeBloc>().add(
                          const HomeLoadInvoices(
                            searchQuery: null,
                            page: 1,
                          ),
                        );
                      });
                    },
                    icon: Icon(
                      Icons.close,
                      color: theme.primary,
                      size: Consts.sizes.icons.sm,
                    ),
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
