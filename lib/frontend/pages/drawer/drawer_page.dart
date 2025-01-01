import 'package:flutter/material.dart';
import 'dart:io';

import 'package:ninenty_second_per_word_app/frontend/pages/drawer/instruction_page.dart'; // Для выхода из приложения

class DrawerPage extends StatelessWidget {
  final PageController pageController;

  const DrawerPage({super.key, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 16, 15, 15),
              Color.fromARGB(255, 26, 25, 25),
              Color.fromARGB(255, 37, 35, 35),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Заголовок
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 13, 13, 13),
                    Color.fromARGB(255, 32, 31, 31),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: _SpecialText(fontSize: 40, text: 'Menu'),
              )
            ),
            // Пункты меню
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  Text(
                    'Navigation',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        color: const Color.fromARGB(221, 250, 250, 250)),
                  ),
                  Divider(
                    endIndent: 2,
                    height: 2,
                    color: const Color.fromARGB(221, 250, 250, 250),
                  ),
                  SizedBox(height: 10,),
                  DrawerItem(
                    icon: Icons.home,
                    title: 'Home',
                    onTap: () {
                      pageController.jumpToPage(0); // Переход на страницу Home
                      Navigator.pop(context); // Закрываем Drawer
                    },
                  ),
                  DrawerItem(
                    icon: Icons.list_alt_outlined,
                    title: 'List of Decks',
                    onTap: () {
                      pageController
                          .jumpToPage(1); // Переход на страницу DeckList
                      Navigator.pop(context);
                    },
                  ),
                  DrawerItem(
                    icon: Icons.favorite,
                    title: 'Favourites',
                    onTap: () {
                      pageController
                          .jumpToPage(2); // Переход на страницу Favourites
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Others',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 25,
                        color: const Color.fromARGB(221, 250, 250, 250)),
                  ),
                  Divider(
                    endIndent: 2,
                    height: 2,
                    color: const Color.fromARGB(221, 250, 250, 250),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DrawerItem(
                    icon: Icons.coffee,
                    title: 'Buy Me Coffee',
                    onTap: () {
                      // Действие при нажатии
                      Navigator.pop(context);
                    },
                  ),
                  DrawerItem(
                    icon: Icons.book,
                    title: 'Instruction',
                    onTap: () {
                      // Действие при нажатии
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InstructionPage(),
                        ),
                      );
                    },
                  ),
                  DrawerItem(
                    icon: Icons.info,
                    title: 'About',
                    onTap: () {
                      // Действие при нажатии
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            // Нижняя кнопка выхода из приложения
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  // Выход из приложения
                  exit(0);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color.fromARGB(228, 218, 62, 62),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.exit_to_app,
                      color: Color.fromARGB(218, 255, 255, 255),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Exit App',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(218, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF2A2A2A),
              Color(0xFF343434),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(2, 2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            _SpecialIcon(icon: icon),
            const SizedBox(width: 15),
            Text(
              title,
              style: const TextStyle(
                color: Color.fromARGB(218, 255, 255, 255),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
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
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
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
              child: Text(
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
    return RichText(
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
                child: Icon(icon, size: 30, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
