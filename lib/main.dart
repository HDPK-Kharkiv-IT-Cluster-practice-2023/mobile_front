import 'package:fightingapp/customicons.dart';
import 'package:fightingapp/skills.dart';
import 'package:fightingapp/themes.dart';
import 'package:flutter/material.dart';
import 'fighting_action.dart';
import 'market.dart';
import 'mob_fighting.dart';
import 'settings.dart';

/// Flutter code sample for [NavigationBar].

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),

      home: NavigationExample(),
      debugShowCheckedModeBanner: false, // Set this to false
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
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
            icon: swordIcon(),
            label: 'Fight',
          ),
          NavigationDestination(
            icon: skullIcon(),
            label: 'Mob Farm',
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
        const FightingAction(),
        const FightingMobs(),
        const Market(),
        const Skills(),
        const Settings()
      ][currentPageIndex],
    );
  }
}
