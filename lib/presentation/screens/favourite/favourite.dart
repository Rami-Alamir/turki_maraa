import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/favourite/favourite_list.dart';
import '../../widgets/shared/empty_list.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../../presentation/widgets/shared/page_builder.dart';
import '../../../controllers/favourite_provider.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';

class Favourite extends StatelessWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favourite = Provider.of<FavouriteProvider>(context);
    return Scaffold(
        appBar: PrimaryAppBar(
          title: AppLocalizations.of(context)!.tr('favorite'),
          back: true,
        ),
        body: PageBuilder(
          isAuth: favourite.isAuth,
          emptyStateTitle: 'empty_favourite',
          emptyStateImage: FixedAssets.emptyFavourite,
          isEmpty: favourite.latLng == null,
          requestStatus: favourite.requestStatus,
          onError: () {
            favourite.getFavouriteList(notify: true);
          },
          child: RefreshIndicator(
              color: Theme.of(context).colorScheme.primary,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              onRefresh: () async {
                await favourite.getFavouriteList();
              },
              child: ((favourite.favourite?.dataT?.data?.length) ?? 0) == 0
                  ? SizedBox(
                      height: SizeConfig.screenHeight,
                      child: const EmptyList(
                        title: 'empty_favourite',
                        image: FixedAssets.emptyFavourite,
                      ),
                    )
                  : const FavouriteList()),
        ));
  }
}
