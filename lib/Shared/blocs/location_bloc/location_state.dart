part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationDetected extends LocationState {
  final LocationResult currentLocation;

  LocationDetected({required this.currentLocation});

  @override
  List<Object> get props => [currentLocation];
}

class LocationError extends LocationState {
  @override
  List<Object> get props => [];
}
