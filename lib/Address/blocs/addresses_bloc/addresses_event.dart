part of 'addresses_bloc.dart';

abstract class AddressesEvent extends Equatable {
  const AddressesEvent();

  @override
  List<Object> get props => [];
}

class GetAllAddresses extends AddressesEvent {}

class SetSelectedAddress extends AddressesEvent {
  final Address address;

  SetSelectedAddress(this.address);

  @override
  List<Object> get props => [address];
}
