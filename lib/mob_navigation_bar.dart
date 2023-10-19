import 'package:fightingapp/customicons.dart';
import 'package:fightingapp/skills.dart';
import 'package:flutter/material.dart';
import 'fighting_action.dart';
import 'market.dart';
import 'mob_fighting.dart';
import 'settings.dart';

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),

      home: MobNavigationExample(),
      debugShowCheckedModeBanner: false, // Set this to false
    );
  }
}

class MobNavigationExample extends StatefulWidget {
  const MobNavigationExample({super.key});

  @override
  State<MobNavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<MobNavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(255, 155, 181, 197),
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            icon: skullIcon(),
            label: 'Fight',
          ),
          NavigationDestination(
            icon: Icon(Icons.storefront,
                color: Theme.of(context).iconTheme.color),
            label: 'Market',
          ),
          NavigationDestination(
            icon: Icon(Icons.toll, color: Theme.of(context).iconTheme.color),
            label: 'Skills',
          ),
          NavigationDestination(
            icon:
                Icon(Icons.settings, color: Theme.of(context).iconTheme.color),
            label: 'Settings',
          ),
        ],
      ),
      body: <Widget>[
        const FightingMobs(),
        const Market(),
        const Skills(),
        const Settings()
      ][currentPageIndex],
    );
  }
}
