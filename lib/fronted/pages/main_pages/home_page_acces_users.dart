import 'package:flutter/material.dart';
import 'package:ninenty_second_per_word_app/fronted/pages/drawer/drawer_page.dart';
import 'package:ninenty_second_per_word_app/fronted/pages/main_pages/favourite_words_page.dart';
import 'package:ninenty_second_per_word_app/fronted/pages/main_pages/home_page.dart';
import 'package:ninenty_second_per_word_app/fronted/pages/main_pages/deck_list_page.dart';
import 'package:ninenty_second_per_word_app/fronted/style/app_colors.dart';
import 'package:ninenty_second_per_word_app/provider/deck_provider.dart';
import 'package:provider/provider.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var _currentIndex = 0;
  final PageController _pageController = PageController();
  final List<Widget> _pages = [
    HomePage(),
    DeckListPage(),
    FavouriteWordsPage(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
     final modelDeck = context.watch<DeckProvider>();

     

void showCustomDialogWithTextField({
  required BuildContext context,
  required String title,
  required String description,
  required String confirmText,
  required String cancelText,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (context) {


      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: const Color.fromARGB(255, 34, 34, 34),
        title: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.edit,
                color: AppColors.greenColor,
                size: 50,
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                description,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                width: double.maxFinite, // Сделаем диалог немного шире
                child: TextField(
                  controller: modelDeck.deckName, //! Добавил контроллер
                  style: TextStyle(color: Colors.white),
                  maxLines: 3, // Ограничение по строкам для многострочного ввода
                  minLines: 1, // Минимум 1 строка
                  decoration: InputDecoration(
                    hintText: 'Enter text...',
                    hintStyle: TextStyle(color: Colors.grey,fontFamily: 'Poppins'),
                    filled: true,
                    fillColor: Colors.black54,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(cancelText, style: TextStyle(color: Colors.white, fontFamily: 'Poppins')),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.greenColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (modelDeck.deckName.text.isNotEmpty) {
                         onConfirm();
                        Navigator.pop(context);
                      } else {
                  
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.black87,
                            title: const Text(
                              'Please enter text',
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK',style: TextStyle(fontFamily: 'Poppins',color: Colors.white),),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: Text(confirmText,style: TextStyle(color: const Color.fromARGB(255, 255, 255, 255),fontFamily: 'Poppins'),),
                  ),
                ],
              )
            ],
          ),
        ),
        // Добавляем ограничение по ширине для диалога
        contentPadding: EdgeInsets.symmetric(horizontal: 20),

      );
    },
  );
}




/*----------------------------------------------------------------------------------------- */


   
   return Scaffold(
  backgroundColor: AppColors.backgroundColor,
  appBar: AppBar(
    iconTheme: const IconThemeData(color: Color.fromARGB(157, 243, 243, 243)),
    centerTitle: true,
    backgroundColor: AppColors.backgroundColor,
    actions: [
      TextButton(
        onPressed: () {
          showCustomDialogWithTextField(
            context: context,
            title: 'Create a deck',
            description: 'Give a name to your deck',
            confirmText: 'Create',
            cancelText: 'Cancel',
            onConfirm: () {
               modelDeck.createDeck();
            },
          );
        },
        child: Text(
          'new deck',
          style: TextStyle(
            color: const Color.fromARGB(157, 243, 243, 243),
            fontFamily: 'Poppins',
            fontSize: 15.5,  // Подкорректировал размер шрифта
          ),
        ),
      ),
    ],
    title: RichText(
      text: TextSpan(
        children: [

          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Transform.translate(
              offset: const Offset(-4, 0), // Подкорректировал смещение текста
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 23, 59, 125),
                    Color.fromARGB(230, 37, 70, 130),
                    Color.fromARGB(246, 48, 37, 123),
                    Color.fromARGB(166, 78, 20, 129),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: const Text(
                  '90 seconds',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 31.3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ),





      drawer: DrawerPage(
        pageController: _pageController

      ),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: AppColors.backgroundColor,
        currentIndex: _currentIndex,
        onTap: onItemTapped,
        duration: Duration(milliseconds: 800),
        itemPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 7),
        items: [
          SalomonBottomBarItem(
            icon: _SpecialIcon(icon: Icons.home_outlined),
            title: _SpecialText(fontSize: 20, text: 'Home'),
            
            
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: _SpecialIcon(icon: Icons.list_alt_outlined),
            title: _SpecialText(fontSize: 20, text: 'List of decks'),
            
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: _SpecialIcon(icon: Icons.favorite_border_outlined),
            title:_SpecialText(fontSize: 18,  text: 'Favourites'),
            
    
            
          ),
        ],
      ),
            body: PageView(
              physics: AlwaysScrollableScrollPhysics() ,
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
    );
  }
}


class _SpecialText extends StatelessWidget {
  final double fontSize;
  final String text;
  const _SpecialText({super.key, required this.fontSize, required this.text});

  @override
  Widget build(BuildContext context) {
    return  RichText(
      text: TextSpan(
        children: [

          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Transform.translate(
              offset: const Offset(-4, -4.5), // Подкорректировал смещение текста
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 23, 59, 125),
                    Color.fromARGB(230, 37, 70, 130),
                    Color.fromARGB(246, 48, 37, 123),
                    Color.fromARGB(166, 78, 20, 129),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child:  Text(
                  text,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class _SpecialIcon extends StatelessWidget {
IconData icon;
   _SpecialIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return  RichText(
      text: TextSpan(
        children: [

          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Transform.translate(
              offset: const Offset(-4, 0), // Подкорректировал смещение текста
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 23, 59, 125),
                    Color.fromARGB(230, 37, 70, 130),
                    Color.fromARGB(246, 48, 37, 123),
                    Color.fromARGB(166, 78, 20, 129),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child:  Icon(icon, size: 30, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}