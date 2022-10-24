import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../controllers/address_provider.dart';
import '../../../controllers/cart_provider.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/get_strings.dart';
import '../../../core/utilities/size_config.dart';
import '../../widgets/cart/cart_bottom_sheet.dart';
import '../../widgets/cart/cart_card.dart';
import '../../widgets/cart/delivery_address.dart';
import '../../widgets/cart/delivery_date.dart';
import '../../widgets/cart/delivery_periods.dart';
import '../../widgets/cart/note.dart';
import '../../widgets/cart/payment_method.dart';
import '../../widgets/cart/promo_code.dart';
import '../../widgets/shared/not_auth.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../widgets/shared/empty_list.dart';
import '../../widgets/shared/retry.dart';
import '../../widgets/shared/spinkit_indicator.dart';

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
    final AddressProvider addressProvider =
        Provider.of<AddressProvider>(context);
    return Scaffold(
        appBar: PrimaryAppBar(
          title: AppLocalizations.of(context)!.tr('cart'),
          back: false,
        ),
        body: !cart.isAuth
            ? const NotAuth()
            : cart.latLng == null
                ? const EmptyList(
                    image: FixedAssets.emptyCart,
                    title: 'empty_cart',
                  )
                : cart.isLoading
                    ? const SpinkitIndicator()
                    : cart.retry
                        ? Retry(
                            onPressed: () {
                              cart.setIsLoading = true;
                              cart.getCartData();
                            },
                          )
                        : (cart.cartData?.data?.cart?.data?.length ?? 0) > 0
                            ? GestureDetector(
                                onTap: () => FocusScope.of(context)
                                    .requestFocus(FocusNode()),
                                child: Stack(
                                  children: [
                                    ListView(
                                      controller: cart.scrollController,
                                      physics: const ScrollPhysics(),
                                      children: [
                                        ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            physics: const ScrollPhysics(),
                                            itemCount: (cart.cartData?.data
                                                    ?.cart?.data?.length ??
                                                0),
                                            itemBuilder:
                                                (BuildContext ctxt, int index) {
                                              return CartCard(
                                                item: cart.cartData!.data!.cart!
                                                    .data![index],
                                                index: index,
                                              );
                                            }),
                                        DeliveryAddress(
                                          address: getAddress(
                                              context, addressProvider, cart),
                                        ),
                                        DeliveryDate(
                                            notIncludedDates: cart.cartData!
                                                .data!.notIncludedDates!,
                                            deliveryDataTime:
                                                cart.deliveryDataTime),
                                        DeliveryPeriods(
                                          deliveryTime: cart.deliveryPeriod,
                                        ),
                                        const PaymentMethod(
                                          withTamara: true,
                                        ),
                                        PromoCode(
                                          errorMsg: cart.errorMsg,
                                          promoCodeController:
                                              cart.promoCodeController,
                                          promoIsActive: cart.promoIsActive,
                                          apply: () {
                                            cart.checkCoupon(context: context);
                                          },
                                          remove: () {
                                            cart.removePromoCode();
                                          },
                                        ),
                                        const Note(),
                                        SizedBox(
                                          height:
                                              SizeConfig.screenHeight! * 0.25,
                                        )
                                      ],
                                    ),
                                    CartBottomSheet(
                                      total: cart
                                          .cartData!
                                          .data!
                                          .invoicePreview!
                                          .totalAmountAfterDiscount!,
                                      min: double.parse(cart.cartData!.data!
                                              .minOrder!.first.minOrder ??
                                          "60"),
                                    )
                                  ],
                                ),
                              )
                            : const EmptyList(
                                image: FixedAssets.emptyCart,
                                title: 'empty_cart',
                              ));
  }
}

String getAddress(context, addressProvider, cartProvider) {
  if (addressProvider.selectedAddress == -1) {
    return GetStrings().currentLocation(
        context,
        cartProvider.currentLocationDescriptionAr,
        cartProvider.currentLocationDescriptionEn);
  } else {
    return addressProvider
        .userAddress!.data![addressProvider.selectedAddress].label;
  }
}
