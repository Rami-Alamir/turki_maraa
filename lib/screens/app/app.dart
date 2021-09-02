import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:new_turki/screens/cart/shopping_cart.dart';
import 'package:new_turki/screens/chat/chat.dart';
import 'package:new_turki/screens/home/home2.dart';
import 'package:new_turki/screens/orders/orders.dart';
import 'package:new_turki/screens/profile/profile.dart';
import 'package:new_turki/utilities/r_a7_i_c_o_n_s_icons.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/utilities/tab_Item.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/widgets/shared/turki_drawer.dart';

//used to build all in one bottom nav bar
class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  // this is static property so other widget throughout the app can access it simply
  static int currentTab = 0;
  int index = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // list tabs here
  List<TabItem> tabs = [];
  AppState() {
    tabs = [
      TabItem(
        page: Home2(parentScaffoldKey: _scaffoldKey),
      ),
      TabItem(
        page: Chat(),
      ),
      TabItem(
        page: ShoppingCart(),
      ),
      TabItem(
        page: Orders(),
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

  final selectedItemColor = Color.fromRGBO(138, 197, 67, 1);
  final unselectedItemColor = Color.fromRGBO(74, 74, 74, 1);
  Future<bool> getDrawer() async {
    final isFirstRouteInCurrentTab =
        !await tabs[currentTab].key.currentState!.maybePop();
    return isFirstRouteInCurrentTab;
  }

  final _advancedDrawerController = AdvancedDrawerController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // WillPopScope handle android back button
    return TurkiDrawer(
      child: WillPopScope(
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
            key: _scaffoldKey,
            //   drawer: getDrawer() ? TurkiDrawer() : null,

            // indexed stack shows only one child
            body: Container(
              child: IndexedStack(
                index: currentTab,
                children: tabs.map((e) => e.page).toList(),
              ),
            ),
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: BottomNavigationBar(
                  backgroundColor: Colors.white10,
                  type: BottomNavigationBarType.fixed,
                  iconSize: 25,
                  showUnselectedLabels: true,
                  selectedItemColor: Theme.of(context).primaryColor,
                  unselectedItemColor: Colors.black38,
                  selectedLabelStyle: TextStyle(fontSize: 12, height: 2),
                  elevation: 0,
                  unselectedLabelStyle: TextStyle(fontSize: 10, height: 2),
                  currentIndex: index,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(RA7ICONS.home),
                      label: "الرئيسية",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(RA7ICONS.comment),
                      label: "مساعدة",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(RA7ICONS.shopping_cart_empty_side_view),
                      label: "السلة",
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(RA7ICONS.box__2_), label: "طلباتي"),
                    BottomNavigationBarItem(
                      icon: Icon(RA7ICONS.user),
                      label: "حسابي",
                    ),
                  ],
                  onTap: (index) {
                    this.index = index;
                    _selectTab(index);
                  }),
            )),
      ),
    );
  }
}
