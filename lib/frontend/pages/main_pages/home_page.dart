import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:ninenty_second_per_word_app/database/hive_box.dart';
import 'package:ninenty_second_per_word_app/frontend/pages/main_pages/flip_card_page.dart';
import 'package:ninenty_second_per_word_app/frontend/style/app_colors.dart';
import 'package:ninenty_second_per_word_app/provider/schedule_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Consumer<ScheduleProvider>(
        builder: (context, scheduleProvider, child) {
          return LiquidPullToRefresh(
            backgroundColor: Color.fromARGB(157, 243, 243, 243),
            showChildOpacityTransition: true,
            animSpeedFactor: 2,
            borderWidth: 4,
            height: 120,
            springAnimationDurationInMilliseconds: 750,
            onRefresh: () async {
              await scheduleProvider.checkAndUpdateDecks();
            },
            child: scheduleProvider.todayDecks.isEmpty
                ? ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 280),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'No decks to show today',
                                style: TextStyle(
                                    color: Color.fromARGB(157, 243, 243, 243),
                                    fontSize: 20),
                              ),
                              SizedBox(height: 20),
                              Icon(Icons.refresh,
                                  size: 48,
                                  color: Color.fromARGB(157, 243, 243, 243)),
                              SizedBox(height: 10),
                              Text(
                                'Pull down to refresh',
                                style: TextStyle(
                                    color: Color.fromARGB(157, 243, 243, 243),
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: scheduleProvider.todayDecks.length,
                    itemBuilder: (context, index) {
                      final deck = scheduleProvider.todayDecks[index];
                      final deckIndex = HiveBox.deck.values.toList().indexOf(deck);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            height: 90,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: const [
                                  Color.fromARGB(255, 23, 59, 125),
                                  Color.fromARGB(230, 37, 70, 130),
                                  Color.fromARGB(246, 48, 37, 123),
                                  Color.fromARGB(166, 78, 20, 129),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: Center(
                              child: ListTile(
                                trailing: Text('Tap to learn',
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 167, 167, 167),
                                        fontSize: 15,
                                        fontFamily: 'Poppins')),
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    
                                    deck.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                        color: Color.fromARGB(255, 210, 210, 210),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                onTap: () {
                                  
                                  Navigator.push(context, MaterialPageRoute(builder:(context) => FlipCardPage(deckIndex: deckIndex,)));
                                   
                                  
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
