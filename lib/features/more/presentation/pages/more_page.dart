import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_constants.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of menu items to show in the "More" page
    final menuItems = [
      {
        'icon': Icons.business,
        'label': 'Branch Management',
        'onTap': () {
          context.pushNamed(RouteConstants.branchManagement);
        },
      },
      {'icon': Icons.settings, 'label': 'Settings', 'onTap': () {}},
      {'icon': Icons.help_outline, 'label': 'Help & Support', 'onTap': () {}},
      {'icon': Icons.info_outline, 'label': 'About', 'onTap': () {}},
      // Add more links here as needed
    ];

    return ListView.separated(
      itemCount: menuItems.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return ListTile(
          leading: Icon(item['icon'] as IconData),
          title: Text(item['label'] as String),
          trailing: const Icon(Icons.chevron_right),
          onTap: item['onTap'] as VoidCallback?,
        );
      },
    );
  }
}
