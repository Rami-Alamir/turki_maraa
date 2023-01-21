import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/home/products_home_body.dart';
import '../../widgets/shared/page_builder.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../../controllers/products_provider.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/t_u_r_k_i_i_c_o_n_s_icons.dart';

class ProductsHome extends StatefulWidget {
  final int id;

  const ProductsHome({Key? key, required this.id}) : super(key: key);
  @override
  ProductsHomeState createState() => ProductsHomeState();
}

class ProductsHomeState extends State<ProductsHome> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(() => setState(() {}));
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    productsProvider.getFoodsPageData(
      widget.id,
    );
    super.initState();
  }

  //used to change appbar icons and title color when user scroll down
  bool get _changeColor {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: ((productsProvider.bannersData?.data?.length ?? 0) == 0)
          ? PrimaryAppBar(
              action: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () => Navigator.pushNamed(context, search),
                  icon: Icon(
                    TURKIICONS.search,
                    size: 25,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            )
          : null,
      body: PageBuilder(
        padding: const EdgeInsets.only(top: 60),
        requestStatus: productsProvider.requestStatus,
        onError: () {
          productsProvider.getFoodsPageData(widget.id);
        },
        child: ProductsHomeBody(
          id: widget.id,
          scrollController: _scrollController,
          changeColor: _changeColor,
        ),
      ),
    );
  }
}
