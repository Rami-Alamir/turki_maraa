import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import '../../widgets/shared/rounded_rectangle_button.dart';
import '../../../controllers/location_provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../controllers/cart_provider.dart';
import '../../../controllers/orders_provider.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class OrderStatus extends StatefulWidget {
  final bool status;

  const OrderStatus({super.key, required this.status});

  @override
  State<OrderStatus> createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  late bool status;
  late int paymentId;
  final RateMyApp _rateMyApp = RateMyApp(
      preferencesPrefix: 'rateMyApp_',
      minDays: 0,
      remindDays: 0,
      remindLaunches: 1,
      minLaunches: 1,
      googlePlayIdentifier: 'com.digishapes.turkieshop',
      appStoreIdentifier: '1115628569');

  void _showRatingDialog() {
    _rateMyApp.showRateDialog(
      context,
      title: AppLocalizations.of(context)!.tr("rating_title"),
      message: AppLocalizations.of(context)!.tr("rating_message"),
      rateButton: AppLocalizations.of(context)!.tr("rate"),
      noButton: AppLocalizations.of(context)!.tr("no_thanks"),
      laterButton: AppLocalizations.of(context)!.tr("later"),
      dialogStyle: const DialogStyle(
          titleAlign: TextAlign.center,
          messageAlign: TextAlign.center,
          messagePadding: EdgeInsets.all(6)),
      onDismissed: () =>
          _rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
    );
  }

  @override
  void initState() {
    status = widget.status;
    context.read<OrdersProvider>().getOrdersList();
    paymentId = context.read<CartProvider>().selectedPayment;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _rateMyApp.init();
      if (!mounted) return;
      final bool isHms = context.read<LocationProvider>().isHms;
      if (mounted && _rateMyApp.shouldOpenDialog && !isHms && status) {
        _showRatingDialog();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: 150,
                height: 150,
                margin: EdgeInsets.only(
                    top: SizeConfig.screenHeight! / 4, bottom: 30),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          status ? AppColors.green : AppColors.red,
                          status
                              ? AppColors.green.withOpacity(0.8)
                              : AppColors.red.withOpacity(0.8),
                        ])),
                child: Icon(
                  status ? Icons.check : Icons.clear,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 90,
                )),
            Text(
              AppLocalizations.of(context)!
                  .tr(status ? "order_successful" : "payment_failed"),
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontSize: 16),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0, bottom: 40),
              width: 250,
              child: Text(
                AppLocalizations.of(context)!.tr(status
                    ? (paymentId == 2
                        ? "the_order_has_been_sent_and_the_payment_is_being_verified"
                        : "thank_order")
                    : paymentId == 7
                        ? "tabby_error"
                        : "payment_failed_description"),
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 14, height: 1.9),
              ),
            ),
            RoundedRectangleButton(
                padding: const EdgeInsets.only(top: 50),
                title: AppLocalizations.of(context)!.tr('continue_shopping'),
                onPressed: () => Navigator.pop(context))
          ],
        ),
      ),
    );
  }
}
