import 'package:equatable/equatable.dart';

final class AddressModel extends Equatable {
  const AddressModel({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
  });

  final String street;
  final String suite;
  final String city;
  final String zipcode;

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      street: json['street'] as String,
      suite: json['suite'] as String,
      city: json['city'] as String,
      zipcode: json['zipcode'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'street': street,
        'suite': suite,
        'city': city,
        'zipcode': zipcode,
      };

  String get formatted => '$street, $suite\n$city $zipcode';

  @override
  List<Object?> get props => [street, suite, city, zipcode];
}
