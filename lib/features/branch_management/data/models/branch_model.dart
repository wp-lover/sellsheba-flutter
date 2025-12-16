import '../../domain/entities/branch_entity.dart';

class BranchModel extends BranchEntity {
  const BranchModel({
    required super.id,
    required super.name,
    required super.address,
    super.zipCode,
    super.district,
    super.city,
    super.contactNumber,
  });

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'] as int,
      name: json['name'] as String,
      address: json['address'] as String? ?? '',
      zipCode: json['zip_code'] as String?,
      district: json['district'] as String?,
      city: json['city'] as String?,
      contactNumber: json['contact_number'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'zip_code': zipCode,
      'district': district,
      'city': city,
      'contact_number': contactNumber,
    };
  }
}
