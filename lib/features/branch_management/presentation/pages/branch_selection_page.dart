import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/route_constants.dart';
import '../bloc/branch_bloc.dart';
import '../bloc/branch_event.dart';
import '../bloc/branch_state.dart';

class BranchSelectionPage extends StatefulWidget {
  const BranchSelectionPage({super.key});

  @override
  State<BranchSelectionPage> createState() => _BranchSelectionPageState();
}

class _BranchSelectionPageState extends State<BranchSelectionPage> {
  @override
  void initState() {
    super.initState();
    context.read<BranchBloc>().add(LoadBranchesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Branch')),
      body: BlocConsumer<BranchBloc, BranchState>(
        listener: (context, state) {
          if (state is BranchSelectionSuccess) {
            context.go(RouteConstants.dashboardPath);
          } else if (state is BranchError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is BranchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BranchLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.branches.length,
              itemBuilder: (context, index) {
                final branch = state.branches[index];
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: const CircleAvatar(child: Icon(Icons.store)),
                    title: Text(
                      branch.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(branch.address),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      context.read<BranchBloc>().add(SelectBranchEvent(branch));
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: Text("No branches found"));
        },
      ),
    );
  }
}
