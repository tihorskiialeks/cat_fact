import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/cat_bloc.dart';
import '../consts/api_consts.dart';
import '../consts/strings.dart';
import '../entities/cat.dart';

class CatFactsScreen extends StatelessWidget {
  const CatFactsScreen({super.key});
  static const double padding = 16;
  @override
  Widget build(final BuildContext context) => const Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _CatImageWidget(),
                SizedBox(height: 10),
                _CatFactWidget(),
                SizedBox(height: 10),
                _CatFactCreatedAtWidget(),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[_GetCatsButton(), _GetCatHistoryButton()],
                ),
              ],
            ),
          ),
        ),
      );
}

class _CatImageWidget extends StatelessWidget {
  const _CatImageWidget();

  @override
  Widget build(final BuildContext context) => BlocBuilder<CatBloc, Cat>(
        key: UniqueKey(),
        builder: (final _, final Cat cat) {
          final MediaQueryData mediaQuery = MediaQuery.of(context);
          final String imageUrl =
              '$kImage?${DateTime.now().millisecondsSinceEpoch}';
          return SizedBox(
            height: mediaQuery.size.width - CatFactsScreen.padding * 2,
            child: Image.network(
              imageUrl,
              loadingBuilder: (
                final _,
                final Widget child,
                final ImageChunkEvent? loadingProgress,
              ) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          );
        },
      );
}

class _GetCatsButton extends StatelessWidget {
  const _GetCatsButton();

  @override
  Widget build(final BuildContext context) {
    final CatBloc bloc = context.read<CatBloc>();
    return ElevatedButton(
      onPressed: () {
        bloc.add(GetCatPressed());
      },
      child: const Text(kNextFact),
    );
  }
}

class _CatFactWidget extends StatelessWidget {
  const _CatFactWidget();

  @override
  Widget build(final BuildContext context) => BlocBuilder<CatBloc, Cat>(
        builder: (final _, final Cat cat) => Text(
          cat.factText,
          maxLines: 3,
        ),
      );
}

class _CatFactCreatedAtWidget extends StatelessWidget {
  const _CatFactCreatedAtWidget();

  @override
  Widget build(final BuildContext context) => BlocBuilder<CatBloc, Cat>(
        builder: (final _, final Cat cat) {
          final ThemeData theme = Theme.of(context);
          return Text(
            DateFormat.yMMMMd(Localizations.localeOf(context).languageCode)
                .format(
              cat.createdAt.toLocal(),
            ),
            style: theme.textTheme.titleLarge,
          );
        },
      );
}

class _GetCatHistoryButton extends StatelessWidget {
  const _GetCatHistoryButton();

  @override
  Widget build(final BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);
    return ElevatedButton(
      onPressed: () async {
        await navigator.pushNamed(kNavigatorToHistory);
      },
      child: const Text(kFactHistory),
    );
  }
}
