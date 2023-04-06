// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadCategory extends CategoryEvent {
  final int categoryId;
  
  LoadCategory({
    required this.categoryId,
  });

  @override
  List<Object> get props => [categoryId];
}

class FillterProducts extends CategoryEvent {
  final String searchTerm;
  
  FillterProducts({
    required this.searchTerm,
  });

  @override
  List<Object> get props => [searchTerm];
}
