import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';
import '../../../controllers/app_provider.dart';
import 'min_value_indicator.dart';
import '../shared/invoice.dart';
import '../shared/rounded_rectangle_button.dart';
import '../../../controllers/cart_provider.dart';
import '../../../controllers/address_provider.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/enum/device_screen_type.dart';
import '../../../core/utilities/size_config.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/get_strings.dart';
import '../../../core/utilities/format_helper.dart';
import '../../../core/utilities/show_snack_bar.dart';
import '../../../core/service/firebase_helper.dart';
import '../../../core/service/service_locator.dart';

class CartBottomSheet extends StatefulWidget {
  const CartBottomSheet({super.key});

  @override
  CartBottomSheetState createState() => CartBottomSheetState();
}

class CartBottomSheetState extends State<CartBottomSheet> {
  bool _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (DraggableScrollableNotification dSNotification) {
        _isExpanded = dSNotification.minExtent == dSNotification.extent;
        setState(() {});
        return true;
      },
      child: Consumer<CartProvider>(
        builder: (_, cartProvider, _) {
          String currency = sl<GetStrings>().getCurrency(
            AppLocalizations.of(context)!.locale!.languageCode,
            context.read<LocationProvider>().isoCountryCode!,
          );
          final double total = cartProvider
              .cartData!
              .data!
              .invoicePreview!
              .totalAmountAfterDiscount!;
          final double myCredit = cartProvider.useCredit
              ? cartProvider.cartData!.data!.customerWallet!
              : 0;
          final double min = cartProvider.cartData!.currentCity?.minPrice ?? 0;
          return DraggableScrollableSheet(
            initialChildSize: min > total
                ? 0.35
                : SizeConfig.deviceScreenType == DeviceScreenType.mobile
                ? 0.25
                : 0.18,
            minChildSize: SizeConfig.deviceScreenType == DeviceScreenType.mobile
                ? 0.25
                : 0.18,
            maxChildSize: 0.5,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Theme.of(context).colorScheme.onSurface,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.shadow.withValues(alpha: 0.2),
                      spreadRadius: 10,
                      blurRadius: 12,
                      offset: const Offset(0, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: ListView(
                  controller: scrollController,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 4,
                          width: 40,
                          margin: const EdgeInsets.only(bottom: 8.0, top: 16),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: Theme.of(
                              context,
                            ).colorScheme.secondaryContainer,
                          ),
                        ),
                      ],
                    ),
                    !_isExpanded
                        ? Column(
                            children: [
                              Invoice(
                                calculateTotal: true,
                                myCredit: myCredit,
                                total: total,
                                subtotal: cartProvider
                                    .cartData!
                                    .data!
                                    .invoicePreview!
                                    .orderSubtotal!,
                                shipping: cartProvider
                                    .cartData!
                                    .data!
                                    .invoicePreview!
                                    .deliveryFee!,
                                discountVoucher: cartProvider
                                    .cartData!
                                    .data!
                                    .invoicePreview!
                                    .discountApplied!,
                                vat:
                                    cartProvider.isoCountryCode.toUpperCase() ==
                                        "AE"
                                    ? "vat_ae"
                                    : 'vat_sa',
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              Container(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                  20.0,
                                  0,
                                  20,
                                  0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 5.0,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(
                                          context,
                                        )!.tr('total'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(fontSize: 16),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 5.0,
                                      ),
                                      child: Text(
                                        '${sl<FormatHelper>().formatDecimalAndRemoveTrailingZeros(((total - myCredit) > 0 ? total - myCredit : 0))} $currency',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium!
                                            .copyWith(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (min > total)
                                MinValueIndicator(
                                  total: total,
                                  min: min,
                                  currency: currency,
                                ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8,
                                ),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.tr(
                                      context
                                                  .read<LocationProvider>()
                                                  .isoCountryCode!
                                                  .toUpperCase() ==
                                              "AE"
                                          ? "vat_ae"
                                          : 'vat_sa',
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(fontSize: 10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                    RoundedRectangleButton(
                      title: AppLocalizations.of(context)!.tr('place_order'),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      fontSize: 16,
                      onPressed: total >= min
                          ? () async {
                              final AddressProvider addressProvider =
                                  Provider.of<AddressProvider>(
                                    context,
                                    listen: false,
                                  );
                              addressProvider.validateAddressId(
                                context
                                    .read<LocationProvider>()
                                    .customerLocationId,
                              );
                              FirebaseHelper().pushAnalyticsEvent(
                                name: "purchase",
                                value: sl<GetStrings>().getPaymentName(
                                  cartProvider.selectedPayment,
                                ),
                              );
                              int statusCode = await cartProvider.placeOrder(
                                context: context,
                                currency: currency,
                                dates: context
                                    .read<AppProvider>()
                                    .adhaConfig
                                    ?.dates,
                                cutStatus: context
                                    .read<AppProvider>()
                                    .adhaConfig
                                    ?.cutStatus,
                                cutId: context
                                    .read<AppProvider>()
                                    .adhaConfig
                                    ?.cutId,
                                addressId:
                                    addressProvider.selectedAddress == -1 ||
                                        addressProvider.selectedAddress == -2
                                    ? -1
                                    : addressProvider
                                          .userAddress!
                                          .data![addressProvider
                                              .selectedAddress]
                                          .id!,
                                language:
                                    AppLocalizations.of(
                                          context,
                                        )!.locale!.languageCode ==
                                        "en"
                                    ? Lang.en
                                    : Lang.ar,
                              );

                              if (context.mounted) {
                                await action(context, statusCode, cartProvider);
                              }
                            }
                          : null,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> action(
    BuildContext context,
    int statusCode,
    CartProvider cartProvider,
  ) async {
    if (statusCode != -1) {
      Navigator.of(context, rootNavigator: true).pop();
      switch (statusCode) {
        case 10:
          ShowSnackBar().show(
            context,
            "it_is_not_possible_to_add_other_items_with_the_sacrifice_items",
          );
          break;
        case 9:
          ShowSnackBar().show(
            context,
            "we_apologize_the_specified_cutting_packaging_not_available_first_day",
          );
          break;
        case 0:
          ShowSnackBar().show(context, "unexpected_error");
          break;
        case 1:
        case 8:
          cartProvider.clearCart();
          Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamed(orderStatus, arguments: true);
          break;
        case 2:
          cartProvider.clearCart();
          Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamed(orderStatus, arguments: true);
          launchUrlString(cartProvider.arb.data!.invoiceURL!);
          break;
        case 4:
          cartProvider.clearCart();
          Navigator.of(context, rootNavigator: true).pushNamed(
            tamaraCheckoutPage,
            arguments: cartProvider.tamara.data!.checkoutUrl!,
          );
          break;
        case 7:
          {
            if (cartProvider.session.availableProducts.installments != null) {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamed(tabbyCheckoutPage, arguments: cartProvider.session);
            } else {
              cartProvider.clearCart();
              cartProvider.setSelectedPayment = 7;
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamed(orderStatus, arguments: false);
            }
          }
          break;
      }
    }
  }
}
