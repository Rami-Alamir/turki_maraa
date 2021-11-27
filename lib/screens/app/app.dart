import 'package:new_turki/screens/cart/shopping_cart.dart';
import 'package:new_turki/screens/chat/chat.dart';
import 'package:new_turki/screens/home/home.dart';
import 'package:new_turki/screens/orders/orders.dart';
import 'package:new_turki/screens/profile/profile.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/r_a7_i_c_o_n_s_icons.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/utilities/tab_Item.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/widgets/shared/drawer/turki_drawer.dart';

//used to build all in one bottom nav bar
class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  // this is static property so other widget throughout the app can access it simply
  static int currentTab = 0;
  int index = 0;
  final GlobalKey<ScaffoldState> _appKey = GlobalKey<ScaffoldState>();

  // list tabs here
  List<TabItem> tabs = [];
  AppState() {
    tabs = [
      TabItem(
        page: Home(),
        // page: Home(parentScaffoldKey: _appKey), route:'/Home',
      ),
      TabItem(
        page: Chat(),
      ),
      TabItem(
        page: ShoppingCart(),
      ),
      TabItem(
        page: Orders(back: false),
      ),
      TabItem(
        page: Profile(),
      ),
    ];

    // indexing is necessary for proper functionality of determining which tab is active
    tabs.asMap().forEach((index, details) {
      details.setIndex(index);
    });
  }

  // sets current tab index and update state
  void _selectTab(int index) {
    if (index == currentTab) {
      // pop to first route  if the user taps on the active tab
      tabs[index].key.currentState?.popUntil((route) => route.isFirst);
    } else {
      // update the state  in order to repaint
      setState(() => currentTab = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // WillPopScope handle android back button
    // return TurkiDrawer(
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await tabs[currentTab].key.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (currentTab != 0) {
            // select 'main' tab
            _selectTab(0);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
          key: _appKey,
          // indexed stack shows only one child
          body: Container(
            child: IndexedStack(
              index: currentTab,
              children: tabs.map((e) => e.page).toList(),
            ),
          ),
          bottomNavigationBar: Container(
            child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                iconSize: 25,
                showUnselectedLabels: true,
                elevation: 0,
                currentIndex: index,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(RA7ICONS.home),
                    label: AppLocalizations.of(context)!.tr('home'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(RA7ICONS.comment),
                    label: AppLocalizations.of(context)!.tr('support'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(RA7ICONS.shopping_cart_empty_side_view),
                    label: AppLocalizations.of(context)!.tr('cart'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(RA7ICONS.box__2_),
                    label: AppLocalizations.of(context)!.tr('orders'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(RA7ICONS.user),
                    label: AppLocalizations.of(context)!.tr('profile'),
                  ),
                ],
                onTap: (index) {
                  this.index = index;
                  _selectTab(index);
                }),
          )),
    );
  }
}
