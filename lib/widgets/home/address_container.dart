import 'package:flutter/material.dart';
import 'package:new_turki/provider/home_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/utilities/size_config.dart';
import 'package:new_turki/widgets/shared/rounded_rectangle_button.dart';
import 'package:provider/provider.dart';

class AddressContainer extends StatefulWidget {
  @override
  _AddressContainerState createState() => _AddressContainerState();
}

class _AddressContainerState extends State<AddressContainer> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    final _homeProvider = Provider.of<HomeProvider>(context);
    final List<String> _addressList = _homeProvider.selectedOrderType == 0
        ? _homeProvider.address
        : _homeProvider.address2;
    return AnimatedContainer(
      duration: Duration(microseconds: 1),
      child: InkWell(
        onTap: () {
          setState(() {
            _selected = !_selected;
          });
        },
        child: Container(
          color: Colors.transparent,
          width: SizeConfig.screenWidth,
          child: Stack(
            children: [
              Container(
                color: Theme.of(context).backgroundColor == Colors.black
                    ? Theme.of(context).colorScheme.secondary
                    : Theme.of(context).primaryColor,
                height: 35,
              ),
              Visibility(
                visible: _selected,
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 20.0, left: 20.0, top: 60),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(7),
                          bottomRight: Radius.circular(7)),
                      color: Theme.of(context).backgroundColor,
                      boxShadow: [],
                    ),
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: SizeConfig.screenWidth,
                              child: ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: ScrollPhysics(),
                                  itemCount: _addressList.length,
                                  itemBuilder: (BuildContext ctxt, int index) {
                                    return InkWell(
                                      onTap: () {
                                        if (_homeProvider.selectedOrderType ==
                                            0)
                                          _homeProvider.selectedAddress = index;
                                        else
                                          _homeProvider.selectedAddress2 =
                                              index;
                                        _selected = false;
                                        setState(() {});
                                      },
                                      child: addressRow(_addressList[index],
                                          divider: index !=
                                              (_homeProvider.selectedOrderType ==
                                                          0
                                                      ? _homeProvider
                                                          .selectedAddress
                                                      : _homeProvider
                                                          .selectedAddress2) -
                                                  1),
                                    );
                                  }),
                            ),
                            Visibility(
                                visible: _homeProvider.selectedOrderType == 0,
                                child: addNewAddress())
                          ],
                        )),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                        color: Theme.of(context).backgroundColor,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryVariant
                                .withOpacity(0.3),
                            blurRadius: 6,
                            spreadRadius: 0.5,
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                _addressList[
                                    _homeProvider.selectedOrderType == 0
                                        ? _homeProvider.selectedAddress
                                        : _homeProvider.selectedAddress2],
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                            Icon(
                              _selected
                                  ? Icons.keyboard_arrow_up_rounded
                                  : Icons.keyboard_arrow_down_rounded,
                              color:
                                  Theme.of(context).textTheme.subtitle2!.color,
                              size: 35,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addressRow(String title, {bool divider = true}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(title,
              style: Theme.of(context)
                  .textTheme
                  .headline1!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.normal)),
        ),
        divider
            ? Divider(
                indent: 20,
                endIndent: 20,
                height: 2,
                color: Theme.of(context)
                    .colorScheme
                    .secondaryVariant
                    .withOpacity(0.3),
              )
            : Padding(
                padding: const EdgeInsets.all(4.0),
              ),
      ],
    );
  }

  Widget addNewAddress() {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/AddNewAddress'),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            RoundedRectangleButton(
              onPressed: () {},
              padding: const EdgeInsets.all(0),
              width: 22,
              height: 22,
              fontSize: 18,
              title: '+',
            ),
            Text(AppLocalizations.of(context)!.tr('add_new_delivery_address'),
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.normal)),
          ],
        ),
      ),
    );
  }
}