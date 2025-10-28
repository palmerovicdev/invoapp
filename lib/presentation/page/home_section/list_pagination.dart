import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invoapp/core/localization/app_locale.dart';

import '../../../core/theme/theme.dart' as app_theme;
import '../../../core/util/feedback.dart';
import '../../state/home/home_bloc.dart';

class ListPagination extends StatelessWidget {
  const ListPagination({
    super.key,
    required this.state,
    required this.theme,
    required this.searchController,
  });

  final HomeState state;
  final app_theme.Theme theme;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Consts.spacing.padding.md.horizontal,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FilledButton(
            onPressed: state.page > 1
                ? () {
                    click(null);
                    context.read<HomeBloc>().add(
                      HomeLoadInvoices(
                        searchQuery: searchController.text.trim(),
                        page: state.page - 1,
                        state: state.filterState,
                        issuedAtGteq: state.issuedAtGteq,
                        issuedAtLteq: state.issuedAtLteq,
                      ),
                    );
                  }
                : null,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(state.page > 1 ? theme.bgLight : theme.bgLight.withOpacity(Consts.ui.opacities.disabled)),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: Consts.radius.containers.sm,
                ),
              ),
            ),
            child: Text(
              context.l10n.previous,
              style: TextStyle(
                color: state.page > 1 ? theme.primary : theme.primary.withOpacity(Consts.ui.opacities.disabled),
              ),
            ),
          ),
          Text(
            '${state.page}',
            style: TextStyle(
              color: theme.primary,
              fontWeight: FontWeight.w700,
              fontSize: context.getResponsiveFontSize(smallest: Consts.fontSizes.device.mobile.body),
            ),
          ),
          FilledButton(
            onPressed: () {
              click(null);
              context.read<HomeBloc>().add(
                HomeLoadInvoices(
                  searchQuery: searchController.text.trim(),
                  page: state.page + 1,
                  state: state.filterState,
                  issuedAtGteq: state.issuedAtGteq,
                  issuedAtLteq: state.issuedAtLteq,
                ),
              );
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(theme.bgLight),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: Consts.radius.containers.sm,
                ),
              ),
            ),
            child: Text(
              context.l10n.next,
              style: TextStyle(
                color: theme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
