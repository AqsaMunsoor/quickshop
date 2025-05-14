part of '../cubit.dart';

@immutable
class ProductFetchState extends Equatable {
  static bool match(ProductState a, ProductState b) => a.fetch != b.fetch;

  final ProductResponse? data;
  final String? message;

  const ProductFetchState({this.message, this.data});

  @override
  List<Object?> get props => [message, data];
}

@immutable
class ProductFetchDefault extends ProductFetchState {}

@immutable
class ProductFetchLoading extends ProductFetchState {}

@immutable
class ProductFetchSuccess extends ProductFetchState {
  const ProductFetchSuccess({required ProductResponse data})
    : super(data: data);
}

@immutable
class ProductFetchFailed extends ProductFetchState {
  const ProductFetchFailed({super.message});
}
