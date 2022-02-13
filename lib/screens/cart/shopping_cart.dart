import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_turki/models/delivery_date_time.dart';
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
    final _cart = Provider.of<CartProvider>(context, listen: false);
    _cart.initDateTimeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _cart = Provider.of<CartProvider>(context);
    final _auth = Provider.of<Auth>(context);
    final _addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    if (_auth.isAuth) print(_auth.accessToken);
    var format =
        DateFormat.E(AppLocalizations.of(context)!.locale!.languageCode);
    var dateString = format.format(DateTime.now());
    print(format.format(DateTime.now()));
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

                        if (_auth.isAuth)
                          _cart.getCartData(
                              _auth.accessToken,
                              _addressProvider.latLng,
                              _addressProvider.isoCountryCode);
                      },
                    )
                  : (_cart.cartData?.data?.cart?.data?.length ?? 0) > 0
                      ? GestureDetector(
                          onTap: () =>
                              FocusScope.of(context).requestFocus(FocusNode()),
                          child: Stack(
                            children: [
                              ListView(
                                physics: const ScrollPhysics(),
                                children: [
                                  ListView.builder(
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      itemCount: (_cart.cartData?.data?.cart
                                              ?.data?.length ??
                                          0),
                                      itemBuilder:
                                          (BuildContext ctxt, int index) {
                                        return CartCard(
                                          item: _cart.cartData!.data!.cart!
                                              .data![index],
                                          index: index,
                                        );
                                      }),
                                  DeliveryAddress(
                                      address:
                                          _addressProvider.selectedAddress == -1
                                              ? AppLocalizations.of(context)!
                                                  .tr('current_location')
                                              : _addressProvider
                                                  .userAddress!
                                                  .data![_addressProvider
                                                      .selectedAddress]
                                                  .address!),
                                  DeliveryDate(
                                      deliveryDataTime: _cart.deliveryDataTime),
                                  DeliveryTime(
                                    deliveryTime: [
                                      DeliveryDateTime(
                                          title: AppLocalizations.of(context)!
                                              .tr('morning_time'),
                                          subtitle: ''),
                                      DeliveryDateTime(
                                          title: AppLocalizations.of(context)!
                                              .tr('noon'),
                                          subtitle: ''),
                                      DeliveryDateTime(
                                          title: AppLocalizations.of(context)!
                                              .tr('afternoon_period'),
                                          subtitle: ''),
                                      DeliveryDateTime(
                                          title: AppLocalizations.of(context)!
                                              .tr('morocco_period'),
                                          subtitle: ''),
                                      DeliveryDateTime(
                                          title: AppLocalizations.of(context)!
                                              .tr('isha_period'),
                                          subtitle: ''),
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
                                invoicePreview:
                                    _cart.cartData!.data!.invoicePreview!,
                              )
                            ],
                          ),
                        )
                      : EmptyCart(),
    );
  }
}
