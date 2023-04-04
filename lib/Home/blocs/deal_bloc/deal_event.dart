part of 'deal_bloc.dart';

abstract class DealEvent extends Equatable {
  const DealEvent();

  @override
  List<Object> get props => [];
}

class FetchDeal extends DealEvent {
  
}