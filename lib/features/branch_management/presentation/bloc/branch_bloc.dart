import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/branch_repository.dart';
import 'branch_event.dart';
import 'branch_state.dart';

class BranchBloc extends Bloc<BranchEvent, BranchState> {
  final BranchRepository repository;

  BranchBloc({required this.repository}) : super(BranchInitial()) {
    on<LoadBranchesEvent>(_onLoadBranches);
    on<SelectBranchEvent>(_onSelectBranch);
  }

  Future<void> _onLoadBranches(
    LoadBranchesEvent event,
    Emitter<BranchState> emit,
  ) async {
    emit(BranchLoading());
    final result = await repository.getBranches();
    result.fold(
      (failure) => emit(const BranchError("Failed to load branches")),
      (branches) => emit(BranchLoaded(branches)),
    );
  }

  Future<void> _onSelectBranch(
    SelectBranchEvent event,
    Emitter<BranchState> emit,
  ) async {
    // We might want to keep showing the list while "selecting" happens,
    // or show a loading overlay. For simplicity, we just fire success.
    final result = await repository.selectBranch(event.branch);
    result.fold(
      (failure) => emit(const BranchError("Failed to select branch")),
      (success) => emit(BranchSelectionSuccess()),
    );
  }
}
