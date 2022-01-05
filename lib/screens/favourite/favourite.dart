import 'package:flutter/material.dart';
import 'package:new_turki/provider/auth.dart';
import 'package:new_turki/provider/favourite_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/favourite/empty_favourite.dart';
import 'package:new_turki/widgets/favourite/favourite_card.dart';
import 'package:new_turki/widgets/shared/not_auth.dart';
import 'package:new_turki/widgets/shared/primary_app_bar.dart';
import 'package:new_turki/widgets/shared/retry.dart';
import 'package:new_turki/widgets/shared/spinkit_indicator.dart';
import 'package:provider/provider.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  void initState() {
    final _auth = Provider.of<Auth>(context, listen: false);
    if (_auth.isAuth) {
      final _favourite = Provider.of<FavouriteProvider>(context, listen: false);
      _favourite.getFavouriteData("Bearer " + _auth.accessToken);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);
    final _favourite = Provider.of<FavouriteProvider>(context);
    return Scaffold(
      appBar: PrimaryAppBar(
        title: AppLocalizations.of(context)!.tr('favorite'),
      ),
      body: !_auth.isAuth
          ? NotAuth()
          : _favourite.isLoading
              ? SpinkitIndicator()
              : _favourite.retry
                  ? Retry(
                      onPressed: () {
                        _favourite.setIsLoading = true;
                        _favourite
                            .getFavouriteData("Bearer " + _auth.accessToken);
                      },
                    )
                  : ((_favourite.favourite.dataT?.data?.length) ?? 0) == 0
                      ? EmptyFavourite()
                      : RefreshIndicator(
                          color: Theme.of(context).primaryColor,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          onRefresh: () async {
                            await _favourite.getFavouriteData(
                                "Bearer " + _auth.accessToken);
                          },
                          child: ListView(
                            children: [
                              ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: (_favourite
                                          .favourite.dataT?.data?.length) ??
                                      0,
                                  padding: EdgeInsets.only(top: 10),
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return FavouriteCard(
                                      accessToken:
                                          "Bearer " + _auth.accessToken,
                                      index: index,
                                      data: _favourite
                                          .favourite.dataT!.data![index],
                                    );
                                  }),
                              Container(height: SizeConfig.screenHeight)
                            ],
                          ),
                        ),
    );
  }
}
