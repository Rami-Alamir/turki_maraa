import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/home/search/custom_search_bar.dart';
import '../../widgets/home/search/search_row.dart';
import '../../../controllers/search_provider.dart';
import '../../../core/utilities/app_localizations.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ListView(
          padding: const EdgeInsets.only(top: 60),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    AppLocalizations.of(context)!.tr('search'),
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      right: 30,
                      left: 30,
                      bottom: 20,
                    ),
                    child: Text(
                      'X',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
              ],
            ),
            const CustomSearchBar(),
            Consumer<SearchProvider>(
              builder: (_, searchProvider, _) {
                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: searchProvider.searchData.length > 10
                      ? 10
                      : searchProvider.searchData.length,
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (BuildContext ctxt, int index) {
                    return SearchRow(item: searchProvider.searchData[index]);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
