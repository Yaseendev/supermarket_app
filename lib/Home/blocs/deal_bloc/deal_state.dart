part of 'deal_bloc.dart';

abstract class DealState extends Equatable {
  const DealState();

  @override
  List<Object?> get props => [];
}

class DealInitial extends DealState {}

class DealLoading extends DealState {}

class DealLoaded extends DealState {
  final Product product;

  DealLoaded(this.product);

  @override
  List<Object?> get props => [product];
}

class DealError extends DealState {
  final String? msg;

    DealError([this.msg]);

  @override
  List<Object?> get props => [msg];
}
