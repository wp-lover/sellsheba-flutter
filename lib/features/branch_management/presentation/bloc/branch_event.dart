import 'package:equatable/equatable.dart';
import '../../domain/entities/branch_entity.dart';

abstract class BranchEvent extends Equatable {
  const BranchEvent();

  @override
  List<Object> get props => [];
}

class LoadBranchesEvent extends BranchEvent {}

class SelectBranchEvent extends BranchEvent {
  final BranchEntity branch;
  const SelectBranchEvent(this.branch);

  @override
  List<Object> get props => [branch];
}
