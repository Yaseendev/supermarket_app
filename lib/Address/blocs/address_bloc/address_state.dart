part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  const AddressState();
  
  @override
  List<Object?> get props => [];
}

class AddressInitial extends AddressState {}
class AddressNoInternet extends AddressState {}

class AddressLoading extends AddressState {}

class AddressError extends AddressState {
  final String? msg;

  AddressError([this.msg]);

  @override
  List<Object?> get props => [msg];
}

class AddressAdded extends AddressState {
  final Address address;

  AddressAdded(this.address);

  @override
  List<Object?> get props => [address];
}

class AddressEdited extends AddressState {
  final Address address;

  AddressEdited(this.address);

  @override
  List<Object?> get props => [address];
}

class AddressDeleted extends AddressState {
  final String id;

  AddressDeleted(this.id);

  @override
  List<Object?> get props => [id];
}