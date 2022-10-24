import 'package:flutter/material.dart';
import '../../../controllers/favourite_provider.dart';
import '../../../core/constants/fixed_assets.dart';
import '../../../core/utilities/app_localizations.dart';
import '../../../core/utilities/size_config.dart';
import '../../widgets/favourite/favourite_card.dart';
import '../../widgets/shared/empty_list.dart';
import '../../widgets/shared/not_auth.dart';
import '../../widgets/shared/primary_app_bar.dart';
import 'package:provider/provider.dart';
import '../../widgets/shared/retry.dart';
import '../../widgets/shared/spinkit_indicator.dart';

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
      body: !favourite.isAuth
          ? const NotAuth()
          : favourite.latLng == null
              ? const EmptyList(
                  title: 'empty_favourite',
                  image: FixedAssets.emptyFavourite,
                )
              : favourite.isLoading
                  ? const SpinkitIndicator()
                  : favourite.retry
                      ? Retry(
                          onPressed: () {
                            favourite.setIsLoading = true;
                            favourite.getFavouriteData();
                          },
                        )
                      : RefreshIndicator(
                          color: Theme.of(context).primaryColor,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          onRefresh: () async {
                            await favourite.getFavouriteData();
                          },
                          child: ((favourite.favourite?.dataT?.data?.length) ??
                                      0) ==
                                  0
                              ? SizedBox(
                                  height: SizeConfig.screenHeight,
                                  child: const EmptyList(
                                    title: 'empty_favourite',
                                    image: FixedAssets.emptyFavourite,
                                  ),
                                )
                              : ListView(
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: (favourite.favourite?.dataT
                                                ?.data?.length) ??
                                            0,
                                        padding: const EdgeInsets.only(top: 10),
                                        itemBuilder:
                                            (BuildContext ctxt, int index) {
                                          return FavouriteCard(
                                            index: index,
                                            data: favourite
                                                .favourite!.dataT!.data![index],
                                          );
                                        }),
                                  ],
                                ),
                        ),
    );
  }
}
