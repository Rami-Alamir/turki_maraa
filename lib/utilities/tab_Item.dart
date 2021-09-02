import 'package:flutter/material.dart';
import 'package:new_turki/screens/app/app.dart';

class TabItem {
  final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();
  int _index = 0;
  late Widget _page;

  TabItem({
    required Widget page,
  }) {
    _page = page;
  }

  // used to set the index of this tab
  // which will be used in identifying if this tab is active
  void setIndex(int i) {
    _index = i;
  }

  int getIndex() => _index;

  // adds a wrapper around the page widgets for visibility
  // visibility widget removes unnecessary problems
  // like interactivity and animations when the page is inactive
  Widget get page {
    return Visibility(
      // only paint this page when currentTab is active
      visible: _index == AppState.currentTab,
      // important to preserve state while switching between tabs
      maintainState: true,
      child: Navigator(
        // key tracks state changes
        key: key,
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(builder: (context) => _page);
        },
      ),
    );
  }
}
