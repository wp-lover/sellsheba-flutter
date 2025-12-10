import 'package:equatable/equatable.dart';

class BranchEntity extends Equatable {
  final int id;
  final String name;
  final String address;

  const BranchEntity({
    required this.id,
    required this.name,
    required this.address,
  });

  @override
  List<Object?> get props => [id, name, address];
}
