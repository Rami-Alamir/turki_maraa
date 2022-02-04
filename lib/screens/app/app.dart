import 'package:flutter_dropdown_alert/dropdown_alert.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/cart_provider.dart';
import 'package:new_turki/screens/cart/shopping_cart.dart';
import 'package:new_turki/screens/chat/chat.dart';
import 'package:new_turki/screens/home/home.dart';
import 'package:new_turki/screens/orders/orders.dart';
import 'package:new_turki/screens/profile/profile.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import 'package:new_turki/utilities/tab_Item.dart';
import 'package:flutter/material.dart';
import 'package:new_turki/widgets/shared/drawer/turki_drawer.dart';
import 'package:provider/provider.dart';

//used to build all in one bottom nav bar
class App extends StatefulWidget {
  final int index;

  const App({this.index = 0});
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
        page: Home(parentScaffoldStateKey: _appKey),
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
  void initState() {
    index = widget.index;
    currentTab = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<CartProvider>(context);
    SizeConfig().init(context);
    // WillPopScope handle android back button
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
      child: TurkiDrawer(
        child: Scaffold(
            key: _appKey,
            // indexed stack shows only one child
            body: Stack(
              children: [
                Container(
                  child: IndexedStack(
                    index: currentTab,
                    children: tabs.map((e) => e.page).toList(),
                  ),
                ),
                // DropdownAlert()
              ],
            ),
            bottomNavigationBar: Container(
              child: BottomNavigationBar(
                  backgroundColor: Theme.of(context).backgroundColor,
                  type: BottomNavigationBarType.fixed,
                  iconSize: 25,
                  showUnselectedLabels: true,
                  elevation: 5,
                  currentIndex: index,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(TURKIICONS.tabnav_home),
                      label: AppLocalizations.of(context)!.tr('home'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(TURKIICONS.ask),
                      label: AppLocalizations.of(context)!.tr('support'),
                    ),
                    BottomNavigationBarItem(
                      label: AppLocalizations.of(context)!.tr('cart'),
                      icon: Stack(clipBehavior: Clip.none, children: <Widget>[
                        Icon(TURKIICONS.cart),
                        Positioned(
                            // draw a red marble
                            top: -5.0,
                            left: -8.0,
                            child: Visibility(
                              visible: _cart.cartLength > 0,
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                                child: Text(
                                  _cart.cartLength.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ),
                            ))
                      ]),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(TURKIICONS.tabnav_myorders),
                      label: AppLocalizations.of(context)!.tr('orders'),
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(TURKIICONS.tabnav_user),
                      label: AppLocalizations.of(context)!.tr('profile'),
                    ),
                  ],
                  onTap: (index) {
                    this.index = index;
                    _selectTab(index);
                    final _auth = Provider.of<Auth>(context, listen: false);
                    if (index == 2 && _auth.isAuth) {
                      final _cart =
                          Provider.of<CartProvider>(context, listen: false);
                      _cart.setIsLoading = true;
                      _cart.setSelectedTime = -1;
                      _cart.setSelectedPayment = -1;
                      _cart.setSelectedDate = -1;
                      _cart.getCartData(_auth.accessToken);
                    }
                  }),
            )),
      ),
    );
  }
}
