part of '../cubit.dart';

@immutable
class CategoryFetchState extends Equatable {
  static bool match(ProductState a, ProductState b) =>
      a.fetchCategory != b.fetchCategory;

  final List<String>? data;
  final String? message;

  const CategoryFetchState({this.message, this.data});

  @override
  List<Object?> get props => [message, data];
}

@immutable
class CategoryFetchDefault extends CategoryFetchState {}

@immutable
class CategoryFetchLoading extends CategoryFetchState {}

@immutable
class CategoryFetchSuccess extends CategoryFetchState {
  const CategoryFetchSuccess({required List<String> data}) : super(data: data);
}

@immutable
class CategoryFetchFailed extends CategoryFetchState {
  const CategoryFetchFailed({super.message});
}
