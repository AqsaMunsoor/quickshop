part of '../cubit.dart';

// Add this to your existing state classes
@immutable
class ProductSearchState extends Equatable {
  final List<Product>? results;
  final String? query;
  final String? message;

  const ProductSearchState({this.results, this.query, this.message});

  @override
  List<Object?> get props => [results, query, message];
}

@immutable
class ProductSearchInitial extends ProductSearchState {}

@immutable
class ProductSearchLoading extends ProductSearchState {
  const ProductSearchLoading({required String query}) : super(query: query);
}

@immutable
class ProductSearchSuccess extends ProductSearchState {
  const ProductSearchSuccess({
    required List<Product> results,
    required String query,
  }) : super(results: results, query: query);
}

@immutable
class ProductSearchFailed extends ProductSearchState {
  const ProductSearchFailed({String? query, String? message})
    : super(query: query, message: message);
}
