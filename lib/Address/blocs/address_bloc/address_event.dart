part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class AddAddress extends AddressEvent {
  final LatLng location;
  final String city;
  final String street;
  final String block;
  final String floor;
  final String phone;

  AddAddress({
    required this.location,
    required this.city,
    required this.street,
    required this.block,
    required this.floor,
    required this.phone,
  });

  @override
  List<Object> get props => [location, city, street, block, floor, phone];
}

class EditAddress extends AddressEvent {
  final Address address;
  EditAddress({
    required this.address,
  });

  @override
  List<Object> get props => [address];

}

class DeleteAddress extends AddressEvent {
  final String id;

  DeleteAddress({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}