import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'bloc/cat_bloc.dart';
import 'consts/strings.dart';
import 'entities/cat.dart';
import 'screens/cat_facts_history_screen.dart';
import 'screens/cat_facts_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CatAdapter());
  await initializeDateFormatting().then((final _) => runApp(const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(final BuildContext context) => BlocProvider<CatBloc>(
        create: (final _) => CatBloc(),
        child: MaterialApp(
          theme: ThemeData(
            textTheme: const TextTheme(
              bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              titleLarge: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
          ),
          initialRoute: '/',
          routes: <String, Widget Function(BuildContext)>{
            kNavigatorToHistory: (final _) => const CatFactsHistory(),
          },
          home: const CatFactsScreen(),
        ),
      );
}
