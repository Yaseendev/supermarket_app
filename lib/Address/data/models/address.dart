import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Address extends Equatable {
  final String? id;
  final LatLng position;
  final String city;
  final String street;
  final String blockNumber;
  final String floorNumber;
  final String phone;
  Address({
    this.id,
    required this.position,
    required this.city,
    required this.street,
    required this.blockNumber,
    required this.floorNumber,
    required this.phone,
  });

  Address copyWith({
    String? id,
    LatLng? position,
    String? city,
    String? street,
    String? blockNumber,
    String? floorNumber,
    String? phone,
  }) {
    return Address(
      id: id ?? this.id,
      position: position ?? this.position,
      city: city ?? this.city,
      street: street ?? this.street,
      blockNumber: blockNumber ?? this.blockNumber,
      floorNumber: floorNumber ?? this.floorNumber,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'lattitude': position.latitude,
      'longitude': position.longitude,
      'city': city,
      'streat_name': street,
      'block_number': blockNumber,
      'floor_number': floorNumber,
      'phone_number': phone,
    };
  }

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      id: map['id'] ?? '',
      position: LatLng(double.parse(map['lattitude'].toString()),
          double.parse(map['longitude'].toString())),
      city: map['city'] ?? '',
      street: map['streat_name'] ?? '',
      blockNumber: map['block_number'] ?? '',
      floorNumber: map['floor_number'] ?? '',
      phone: map['phone_number'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return '$street, $city';
  }

  @override
  List<Object?> get props =>
      [id, position, city, street, blockNumber, floorNumber, phone];
}
