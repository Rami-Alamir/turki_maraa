import 'package:flutter/material.dart';
import 'package:new_turki/provider/search_provider.dart';
import 'package:new_turki/utilities/app_localizations.dart';
import 'package:new_turki/widgets/home/search_bar.dart';
import 'package:new_turki/widgets/home/search_row.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    final _searchProvider = Provider.of<SearchProvider>(context);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          padding: EdgeInsets.only(top: 60),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(AppLocalizations.of(context)!.tr('search'),
                      style: TextStyle(
                          color: Color.fromRGBO(90, 4, 9, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, right: 30, left: 30, bottom: 20),
                    child: Text('X',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
              ],
            ),
            SearchBar(
              controller: _searchProvider.searchController,
              autoFocus: true,
            ),
            ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _searchProvider.searchData.length,
                padding: EdgeInsets.all(0),
                itemBuilder: (BuildContext ctxt, int index) {
                  return SearchRow(
                    item: _searchProvider.searchData[index],
                  );
                })
          ],
        ),
      ),
    );
  }
}
