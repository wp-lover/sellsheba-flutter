import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_constants.dart';
import '../../../../features/more/presentation/pages/more_page.dart';

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
    MorePage(),
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
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.account_circle),
              onSelected: (value) {
                if (value == 'profile') {
                  context.pushNamed(RouteConstants.profile);
                } else if (value == 'logout') {
                  // TODO: Implement actual logout logic (clear tokens, etc.)
                  context.goNamed(RouteConstants.login);
                } else if (value == 'staff') {
                  // TODO: Navigate to staff management
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem<String>(
                    value: 'profile',
                    child: Row(
                      children: [
                        Icon(Icons.person, color: Colors.grey),
                        SizedBox(width: 8),
                        Text('Profile'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'staff',
                    child: Row(
                      children: [
                        Icon(Icons.people, color: Colors.grey),
                        SizedBox(width: 8),
                        Text('Manage Staff'),
                      ],
                    ),
                  ),
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.grey),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                  ),
                ];
              },
            ),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type:
            BottomNavigationBarType.fixed, // Use fixed for clarity with 4 items
      ),
    );
  }
}
