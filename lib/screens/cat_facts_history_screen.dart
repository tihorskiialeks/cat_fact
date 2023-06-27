// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../data_sporage/cat_data_storage.dart';
import '../entities/cat.dart';

class CatFactsHistory extends StatelessWidget {
  const CatFactsHistory({super.key});

  @override
  Widget build(final BuildContext context) {
    final CatDataStorage catDataStorage = CatDataStorage();
    final Future<List<Cat>> cats = catDataStorage.getAllCats();
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Cat>>(
        future: cats,
        builder: (final _, final AsyncSnapshot<List<Cat>> snapshot) => Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  if (snapshot.data != null)
                    for (final Cat cat in snapshot.data!) ...<Widget>[
                      CatFactHistoryCard(cat: cat),
                      const SizedBox(height: 12),
                    ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CatFactHistoryCard extends StatelessWidget {
  const CatFactHistoryCard({
    required this.cat,
    super.key,
  });
  final Cat cat;
  @override
  Widget build(final BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      height: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(cat.factText, maxLines: 2),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              DateFormat.yMMMMd(Localizations.localeOf(context).languageCode)
                  .format(cat.createdAt.toLocal()),
              style: theme.textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(final DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Cat>('cat', cat));
  }
}
