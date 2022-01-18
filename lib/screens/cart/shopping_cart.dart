import 'package:flutter/material.dart';
import 'package:new_turki/dummy_data/dd.dart';
import 'package:new_turki/provider/address_provider.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/cart_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/cart/cart_bottom_sheet.dart';
import 'package:new_turki/widgets/cart/cart_card.dart';
import 'package:new_turki/widgets/cart/delivery_address.dart';
import 'package:new_turki/widgets/cart/delivery_date.dart';
import 'package:new_turki/widgets/cart/delivery_time.dart';
import 'package:new_turki/widgets/cart/empty_cart.dart';
import 'package:new_turki/widgets/cart/note.dart';
import 'package:new_turki/widgets/cart/payment_method.dart';
import 'package:new_turki/widgets/cart/use_credit.dart';
import 'package:new_turki/widgets/shared/not_auth.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:new_turki/widgets/shared/retry.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
import 'package:provider/provider.dart';

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<CartProvider>(context);
    final _auth = Provider.of<Auth>(context);
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    if (_auth.isAuth) print(_auth.accessToken);
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr('cart'),
        back: false,
      ),
      body: !_auth.isAuth
          ? NotAuth()
          : _cart.isLoading
              ? SpinkitIndicator()
              : _cart.retry
                  ? Retry(
                      onPressed: () {
                        _cart.setIsLoading = true;
                        if (_auth.isAuth) _cart.getCartData(_auth.accessToken);
                      },
                    )
                  : (_cart.cartData?.data?.data?.length ?? 0) > 0
                      ? RefreshIndicator(
                          color: Theme.of(context).primaryColor,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          onRefresh: () async {
                            // await _cart.reInitOrdersList();
                          },
                          child: GestureDetector(
                            onTap: () => FocusScope.of(context)
                                .requestFocus(FocusNode()),
                            child: Stack(
                              children: [
                                ListView(
                                  physics: const ScrollPhysics(),
                                  children: [
                                    ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: _cart
                                                .cartData?.data?.data?.length ??
                                            0,
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {
                                          return CartCard(
                                            item: _cart
                                                .cartData!.data!.data![index],
                                            index: index,
                                          );
                                        }),
                                    DeliveryAddress(
                                        address:
                                            _addressProvider.selectedAddress ==
                                                    -1
                                                ? AppLocalizations.of(context)!
                                                    .tr('current_location')
                                                : _addressProvider
                                                    .userAddress!
                                                    .data![_addressProvider
                                                        .selectedAddress]
                                                    .address!),
                                    DeliveryDate(
                                      dateList: [
                                        DeliveryDateTime(
                                            title: '14', subtitle: 'اليوم'),
                                        DeliveryDateTime(
                                            title: '15', subtitle: 'غدا'),
                                        DeliveryDateTime(
                                            title: '16', subtitle: 'الجمعة'),
                                        DeliveryDateTime(
                                            title: '17', subtitle: 'السبت'),
                                        DeliveryDateTime(
                                            title: '18', subtitle: 'الاحد'),
                                        DeliveryDateTime(
                                            title: '19', subtitle: 'الاثنين'),
                                      ],
                                    ),
                                    DeliveryTime(
                                      deliveryTime: [
                                        DeliveryDateTime(
                                            title: 'فترة الصباح',
                                            subtitle: 'اليوم'),
                                        DeliveryDateTime(
                                            title: 'فترة الظهر',
                                            subtitle: 'غدا'),
                                        DeliveryDateTime(
                                            title: 'فترة العصر',
                                            subtitle: 'الجمعة'),
                                        DeliveryDateTime(
                                            title: 'فترة المغرب',
                                            subtitle: 'السبت'),
                                        DeliveryDateTime(
                                            title: 'فترة العشاء',
                                            subtitle: 'الاحد'),
                                      ],
                                    ),
                                    PaymentMethod(),
                                    UseCredit(
                                        credit: _auth.userData!.data!.wallet!),
                                    Note(),
                                    SizedBox(
                                      height: SizeConfig.screenHeight! * 0.25,
                                    )
                                  ],
                                ),
                                CartBottomSheet(
                                  total: 100,
                                )
                              ],
                            ),
                          ),
                        )
                      : EmptyCart(),
    );
  }
}
