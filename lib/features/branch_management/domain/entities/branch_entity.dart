import 'package:equatable/equatable.dart';

class BranchEntity extends Equatable {
  final int id;
  final String name;
  final String address;
  final String? zipCode;
  final String? district;
  final String? city;
  final String? contactNumber;

  const BranchEntity({
    required this.id,
    required this.name,
    required this.address,
    this.zipCode,
    this.district,
    this.city,
    this.contactNumber,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    address,
    zipCode,
    district,
    city,
    contactNumber,
  ];
}
