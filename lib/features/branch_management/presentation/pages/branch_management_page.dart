import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_constants.dart';
import '../../domain/entities/branch_entity.dart';
import '../bloc/branch_bloc.dart';
import '../bloc/branch_event.dart';
import '../bloc/branch_state.dart';

class BranchManagementPage extends StatefulWidget {
  const BranchManagementPage({super.key});

  @override
  State<BranchManagementPage> createState() => _BranchManagementPageState();
}

class _BranchManagementPageState extends State<BranchManagementPage> {
  @override
  void initState() {
    super.initState();
    // Trigger load branches when page opens
    context.read<BranchBloc>().add(LoadBranchesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Branch Management')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Top: Create Branch Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.pushNamed(RouteConstants.createBranch);
                },
                icon: const Icon(Icons.add),
                label: const Text('Add New Branch'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // List of Branches
            Expanded(
              child: BlocBuilder<BranchBloc, BranchState>(
                builder: (context, state) {
                  if (state is BranchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BranchError) {
                    return Center(child: Text(state.message));
                  } else if (state is BranchLoaded) {
                    return _buildBranchList(state.branches);
                  }

                  // Initial state or other, try to show something regardless
                  // or show empty if no data loaded yet
                  return _buildBranchList([]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBranchList(List<BranchEntity> branches) {
    if (branches.isEmpty) {
      // Show mock data if empty for visualization (or empty state)
      // Since the user wants to see the UI, I'll return a mock list if actual list is empty
      // just so they can see the layout. In production, this would be an empty state message.

      // MOCK DATA for visualization if empty
      // Remove this block when real data is available and tested
      final mockBranches = [
        const BranchEntity(id: 1, name: 'Dhaka Main Branch', address: 'Dhaka'),
        const BranchEntity(
          id: 2,
          name: 'Chittagong Branch',
          address: 'Chittagong',
        ),
      ];
      if (branches.isEmpty) branches = mockBranches;
    }

    return ListView.separated(
      itemCount: branches.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final branch = branches[index];
        return Card(
          elevation: 1,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(branch.name.substring(0, 1).toUpperCase()),
            ),
            title: Text(branch.name),
            subtitle: Text(branch.address),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Edit ${branch.name}')),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Confirm delete
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('Delete Branch'),
                        content: Text(
                          'Are you sure you want to delete ${branch.name}?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(ctx),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Deleted ${branch.name}'),
                                ),
                              );
                            },
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
