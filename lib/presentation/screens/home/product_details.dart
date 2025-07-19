import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/home/product_details/circle_icon.dart';
import '../../widgets/home/product_details/product_details_footer.dart';
import '../../widgets/home/product_details/product_details_list.dart';
import '../../widgets/shared/page_builder.dart';
import '../../../core/utilities/enum/request_status.dart';
import '../../../controllers/favourite_provider.dart';
import '../../../controllers/product_provider.dart';
import '../../../core/utilities/app_localizations.dart';

class ProductDetails extends StatefulWidget {
  final Map<String, dynamic> data;

  const ProductDetails({super.key, required this.data});
  @override
  ProductDetailsState createState() => ProductDetailsState();
}

class ProductDetailsState extends State<ProductDetails> {
  int _count = 1;
  int? _index;
  int? _similarIndex;

  @override
  void initState() {
    final ProductProvider productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    _index = productProvider.productData.length;
    _similarIndex = productProvider.similarProductsList.length;
    productProvider.initLoading(_index!);
    productProvider.initExtras();
    productProvider.getProductData(widget.data['id'].toString(), _index!, true);
    productProvider.getSimilarProducts(
      _similarIndex!,
      widget.data['categoryId'].toString(),
    );
    final FavouriteProvider favourite = Provider.of<FavouriteProvider>(
      context,
      listen: false,
    );
    productProvider.setIsFavourite = favourite.isFavourite(widget.data['id']);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ProductDetails oldWidget) {
    final FavouriteProvider favourite = Provider.of<FavouriteProvider>(
      context,
      listen: false,
    );
    final ProductProvider productProvider = Provider.of<ProductProvider>(
      context,
    );
    productProvider.setIsFavourite = favourite.isFavourite(widget.data['id']);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final ProductProvider productProvider = Provider.of<ProductProvider>(
      context,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: PageBuilder(
        padding: const EdgeInsets.only(top: 60),
        requestStatus: productProvider.requestStatus[_index!],
        onError: () {
          productProvider.setProductIsLoading(_index!);
          productProvider.getProductData(
            widget.data['id'].toString(),
            _index!,
            false,
          );
        },
        child: Stack(
          children: [
            RefreshIndicator(
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              onRefresh: () async {
                await productProvider.getProductData(
                  widget.data['id'].toString(),
                  _index!,
                  false,
                );
              },
              child: ProductDetailsList(
                index: _index!,
                similarIndex: _similarIndex!,
              ),
            ),
            Positioned.directional(
              start: 20,
              top: 52,
              textDirection:
                  AppLocalizations.of(context)!.locale == const Locale('ar')
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: CircleIcon(
                icon: Icons.arrow_back_ios,
                onTap: () {
                  Navigator.pop(context);
                },
                padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0, 0, 0),
              ),
            ),
          ],
        ),
      ),
      bottomSheet:
          productProvider.requestStatus[_index!] == RequestStatus.completed &&
              productProvider.productData[_index!].data!.isActive! &&
              productProvider.productData[_index!].data!.isAvailable!
          ? ProductDetailsFooter(
              categoryId: widget.data['categoryId'],
              count: _count,
              index: _index!,
              subtract: () {
                setState(() {
                  _count = _count == 1 ? _count : _count - 1;
                });
              },
              add: () {
                setState(() {
                  _count += 1;
                });
              },
            )
          : null,
    );
  }
}
