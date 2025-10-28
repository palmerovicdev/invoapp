import 'package:animate_do/animate_do.dart';
import 'package:consts/constants/constants.dart';
import 'package:flutter/material.dart';

import '../../widget/circle_button.dart';
import '../../widget/search_bar.dart';

class NavigationAndSearch extends StatefulWidget {
  const NavigationAndSearch({super.key, required this.state, required this.scrollToNext, required this.scrollToPrevious});

  final dynamic state;
  final VoidCallback scrollToNext;
  final VoidCallback scrollToPrevious;

  @override
  State<NavigationAndSearch> createState() => _NavigationAndSearchState();
}

class _NavigationAndSearchState extends State<NavigationAndSearch> with TickerProviderStateMixin {
  AnimationController? searchController;

  bool _showSearch = false;
  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController?.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_showSearch) {
      return ZoomIn(
        manualTrigger: true,
        controller: (controller) => {
          searchController = controller..forward(),
        },
        child: CustomSearchBar(
          searchController: _searchTextController,
          onNotShow: () => {
            searchController?.reverse().then(
              (_) => {
                setState(() {
                  _showSearch = false;
                }),
                searchController?.forward(),
              },
            ),
          },
          showSearch: _showSearch,
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Consts.spacing.base.lg, vertical: Consts.spacing.base.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleButton(
            icon: Icons.arrow_circle_down,
            onTap: widget.scrollToNext,
            enabled: widget.state.selectedInvoiceIndex < widget.state.invoices.length - 1,
          ),
          Consts.spacing.gapHorizontal.lg,
          CircleButton(
            icon: Icons.saved_search_sharp,
            size: Consts.sizes.base.xxxl,
            onTap: () => setState(() {
              _showSearch = true;
            }),
            enabled: true,
          ),
          Consts.spacing.gapHorizontal.lg,
          CircleButton(
            icon: Icons.arrow_circle_up,
            onTap: widget.scrollToPrevious,
            enabled: widget.state.selectedInvoiceIndex > 0,
          ),
        ],
      ),
    );
  }
}
