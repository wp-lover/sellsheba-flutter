import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
// Import your placeholder pages (you'll create these later)
// import 'home_page.dart';
// import 'inventory_page.dart';

class MainDashboardShell extends StatefulWidget {
  const MainDashboardShell({super.key});

  @override
  State<MainDashboardShell> createState() => _MainDashboardShellState();
}

class _MainDashboardShellState extends State<MainDashboardShell> {
  int _selectedIndex = 0;

  // Placeholder list of destination widgets
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home Screen Placeholder'),
    Text('Inventory Screen Placeholder'),
    Text('Orders Screen Placeholder'),
    Text('Settings Screen Placeholder'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Standard App Bar (Header)
      appBar: AppBar(
        title: const Text('SellSheba Connect | [Branch Name]'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Implement settings navigation
            },
          ),
          IconButton(
            // Example: Button to toggle theme mode (for testing)
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.wb_sunny
                  : Icons.nights_stay,
            ),
            onPressed: () {
              // NOTE: Actual theme switching requires state management (e.g., BLoC or Provider)
              // at the root of the app, which we will address later.
              // This is a placeholder for the action.
            },
          ),
        ],
      ),

      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),

      // Bottom Navigation (Footer)
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Orders'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type:
            BottomNavigationBarType.fixed, // Use fixed for clarity with 4 items
      ),
    );
  }
}
