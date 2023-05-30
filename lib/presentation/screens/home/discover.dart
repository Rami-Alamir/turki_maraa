import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../widgets/home/discover/discover_header.dart';
import '../../widgets/home/discover/discover_list.dart';
import '../../widgets/shared/page_builder.dart';
import '../../widgets/shared/primary_app_bar.dart';
import '../../../controllers/discover_provider.dart';
import '../../../models/discover_data.dart';
import '../../../core/utilities/app_localizations.dart';

class Discover extends StatefulWidget {
  final Data item;

  const Discover({Key? key, required this.item}) : super(key: key);

  @override
  DiscoverState createState() => DiscoverState();
}

class DiscoverState extends State<Discover> {
  @override
  void initState() {
    final DiscoverProvider discoverProvider =
        Provider.of<DiscoverProvider>(context, listen: false);
    discoverProvider.getDiscoverItem(widget.item.id!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DiscoverProvider discoverProvider =
        Provider.of<DiscoverProvider>(context);
    final bool isAr =
        AppLocalizations.of(context)!.locale == const Locale('ar');
    return Scaffold(
      appBar: PrimaryAppBar(
        title: isAr ? widget.item.titleAr : widget.item.titleEn,
        back: true,
      ),
      body: PageBuilder(
        requestStatus: discoverProvider.requestStatus,
        onError: () {
          discoverProvider.getDiscoverItem(widget.item.id!);
        },
        child: RefreshIndicator(
          color: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          onRefresh: () async {
            await discoverProvider.getDiscoverItem(widget.item.id!);
          },
          child: ListView(
            children: const [DiscoverHeader(), DiscoverList()],
          ),
        ),
      ),
    );
  }
}
