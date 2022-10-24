import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../../controllers/cart_provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/constants/constants.dart';
import '../../../core/service/firebase_helper.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';
import '../../../core/utilities/tab_item.dart';
import 'package:provider/provider.dart';
import '../../widgets/home/drawer/turki_drawer.dart';
import '../cart/shopping_cart.dart';
import '../home/home.dart';
import '../orders/orders.dart';
import '../profile/profile.dart';
import 'package:url_launcher/url_launcher_string.dart';

//used to build all in one bottom nav bar
class App extends StatefulWidget {
  final int index;

  const App({Key? key, this.index = 0}) : super(key: key);
  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<App> {
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    Navigator.pushNamed(
      context,
      message.data['type'],
    );
  }

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
        page: Container(),
      ),
      TabItem(
        page: const ShoppingCart(),
      ),
      TabItem(
        page: const Orders(back: false),
      ),
      TabItem(
        page: const Profile(),
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
    setupInteractedMessage();
    index = widget.index;
    currentTab = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CartProvider cart = Provider.of<CartProvider>(context);
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
                IndexedStack(
                  index: currentTab,
                  children: tabs.map((e) => e.page).toList(),
                ),
                // DropdownAlert()
              ],
            ),
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                  canvasColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent),
              child: BottomNavigationBar(
                  backgroundColor: Theme.of(context).backgroundColor,
                  type: BottomNavigationBarType.fixed,
                  iconSize: 25,
                  showUnselectedLabels: true,
                  elevation: 5,
                  currentIndex: index,
                  items: [
                    BottomNavigationBarItem(
                      icon: const Icon(TURKIICONS.tabnav_home),
                      label: AppLocalizations.of(context)!.tr('home'),
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(TURKIICONS.c1),
                      label: AppLocalizations.of(context)!.tr('support'),
                    ),
                    BottomNavigationBarItem(
                      label: AppLocalizations.of(context)!.tr('cart'),
                      icon: Stack(clipBehavior: Clip.none, children: <Widget>[
                        const Icon(TURKIICONS.cart),
                        Positioned(
                            // draw a red marble
                            top: -5.0,
                            left: -8.0,
                            child: Visibility(
                              visible: cart.cartLength > 0,
                              child: Container(
                                width: 15,
                                height: 15,
                                decoration: const BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                                child: AutoSizeText(
                                  cart.cartLength.toString(),
                                  textAlign: TextAlign.center,
                                  minFontSize: 6,
                                  maxFontSize: 12,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                              ),
                            ))
                      ]),
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(TURKIICONS.tabnav_myorders),
                      label: AppLocalizations.of(context)!.tr('orders'),
                    ),
                    BottomNavigationBarItem(
                      icon: const Icon(TURKIICONS.tabnav_user),
                      label: AppLocalizations.of(context)!.tr('profile'),
                    ),
                  ],
                  onTap: (index) {
                    if (index != 1) {
                      this.index = index;
                      _selectTab(index);
                    }
                    if (index == 2 && cart.isAuth) {
                      cart.setIsLoading = true;
                      cart.initSomeValues();
                      cart.getCartData();
                    } else if (index == 1) {
                      final LocationProvider locationProvider =
                          Provider.of<LocationProvider>(context, listen: false);
                      FirebaseHelper()
                          .pushAnalyticsEvent(name: "contact_support");
                      _launchURL(locationProvider.isoCountryCode == "AE"
                          ? "tel:${KConstants.uaePhone}"
                          : "tel:${KConstants.ksaPhone}");
                    }
                  }),
            )),
      ),
    );
  }

  //used to make calls, whatsapp
  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (_) {}
  }
}
