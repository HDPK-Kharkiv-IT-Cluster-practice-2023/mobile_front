import 'package:flutter/material.dart';
import 'fightingAction.dart';
import 'market.dart';
import 'mobFighting.dart';
import 'settings.dart';

/// Flutter code sample for [NavigationBar].

void main() => runApp(const NavigationBarApp());

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
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
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(255, 155, 181, 197),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.sports_martial_arts),
            label: 'Fight',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_dining),
            label: 'Mob Farm',
          ),
          NavigationDestination(
            icon: Icon(Icons.storefront),
            label: 'Market',
          ),
        ],
      ),
      body: <Widget>[
        const FightingAction(),
        const FightingMobs(),
        const Market(),
        const Settings()
      ][currentPageIndex],
    );
  }
}
