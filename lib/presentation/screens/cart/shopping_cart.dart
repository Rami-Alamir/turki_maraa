import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/cart/cart_bottom_sheet.dart';
import '../../widgets/cart/cart_items_list.dart';
import '../../widgets/cart/delivery_address.dart';
import '../../widgets/cart/delivery_date.dart';
import '../../widgets/cart/delivery_periods.dart';
import '../../widgets/cart/note.dart';
import '../../widgets/cart/payment_method.dart';
import '../../widgets/cart/promo_code.dart';
import '../../widgets/shared/maintenance.dart';
import '../../widgets/shared/page_builder.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../widgets/shared/empty_list.dart';
import '../../../controllers/home_provider.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  ShoppingCartState createState() => ShoppingCartState();
}

class ShoppingCartState extends State<ShoppingCart> {
  @override
  void initState() {
    final CartProvider cart = Provider.of<CartProvider>(context, listen: false);
    cart.initDateTimeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CartProvider cart = Provider.of<CartProvider>(context);
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
        appBar: PrimaryAppBar(
          title: AppLocalizations.of(context)!.tr('cart'),
          back: false,
        ),
        body: PageBuilder(
          isAuth: cart.isAuth,
          requestStatus: cart.requestStatus,
          isEmpty: cart.latLng == null,
          emptyStateImage: FixedAssets.emptyCart,
          emptyStateTitle: 'empty_cart',
          onError: () {
            cart.getCartData(isLoading: true);
          },
          child: (cart.cartData?.data?.cart?.data?.length ?? 0) > 0
              ? GestureDetector(
                  onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                  child: homeProvider.maintenanceStatus
                      ? const Maintenance()
                      : Stack(
                          children: [
                            ListView(
                              controller: cart.scrollController,
                              physics: const ScrollPhysics(),
                              children: [
                                const CartItemsList(),
                                const DeliveryAddress(),
                                const DeliveryDate(),
                                const DeliveryPeriods(),
                                const PaymentMethod(),
                                const PromoCode(),
                                const Note(),
                                SizedBox(
                                  height: SizeConfig.screenHeight! * 0.25,
                                )
                              ],
                            ),
                            const CartBottomSheet()
                          ],
                        ),
                )
              : const EmptyList(
                  image: FixedAssets.emptyCart,
                  title: 'empty_cart',
                ),
        ));
  }
}
