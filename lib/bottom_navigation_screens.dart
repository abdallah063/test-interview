import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_interview/screen/api_post_screen.dart';
import 'package:test_interview/screen/local_json_screen.dart';
import 'package:test_interview/screen/sqlite_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int? currentIndex = 2;
  List<Widget> screens = [
    SqliteScreen(),
    LocalJsonScreen(),
    ApiPostScreen(),

  ];

  @override
  void setState(VoidCallback fn) {
    // loginController.isSinging();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
          return Scaffold(

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex!,
              onTap: (index) async {
                setState(() {
                  currentIndex = index;

                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Profile',
                  backgroundColor: Colors.deepOrangeAccent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'PostScreen',
                  backgroundColor: Colors.amber,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'test',
                  backgroundColor: Colors.amber,
                ),
              ],
            ),
            body: screens[currentIndex!],
          );
  }
}
