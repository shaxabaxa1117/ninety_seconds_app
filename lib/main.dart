import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ninenty_second_per_word_app/database/DeckModel.dart';
import 'package:ninenty_second_per_word_app/database/CardModel.dart';
import 'package:ninenty_second_per_word_app/fronted/pages/main_pages/adding_card_page.dart';
import 'package:ninenty_second_per_word_app/fronted/pages/main_pages/deck_list_page.dart';
import 'package:ninenty_second_per_word_app/fronted/pages/main_pages/edit_note_page.dart';
import 'package:ninenty_second_per_word_app/fronted/pages/main_pages/favourite_words_page.dart';
import 'package:ninenty_second_per_word_app/fronted/pages/main_pages/home_page.dart';
import 'package:ninenty_second_per_word_app/fronted/pages/main_pages/home_page_acces_users.dart';
import 'package:ninenty_second_per_word_app/fronted/pages/main_pages/splash_screen.dart';
import 'package:ninenty_second_per_word_app/provider/deck_provider.dart';
import 'package:ninenty_second_per_word_app/provider/schedule_provider.dart';
import 'package:provider/provider.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DeckModelAdapter());
  Hive.registerAdapter(CardModelAdapter());
  await Hive.openBox<DeckModel>('deck');
  await Hive.openBox<DateTime>('schedule');
  await Hive.openBox<CardModel>('fav_cards');




  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DeckProvider()),
        ChangeNotifierProvider(create: (context) => ScheduleProvider()),
      ],
      child: MainWidget(),
    );
  }
}

class MainWidget extends StatelessWidget {
  const MainWidget({super.key});

  @override
  Widget build(BuildContext context) { 
    return MaterialApp(
      home: MainPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: Colors.white,
          ),
        ),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),
      routes: {
       // '/edit_page': (context) => const EditNotePage(),
        '/home': (context) => HomePage(), // Пример
        '/deck_list': (context) => DeckListPage(),
        '/fav': (context) => FavouriteWordsPage(),
      },
    );
  }
}


class AnotherMainPage extends StatelessWidget {
  const AnotherMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainPage();
  }
}





