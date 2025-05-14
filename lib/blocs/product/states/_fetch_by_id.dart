part of '../cubit.dart';

@immutable
class FetchByIdState extends Equatable {
  static bool match(ProductState a, ProductState b) =>
      a.fetchById != b.fetchById;

  final Product? data;
  final String? message;

  const FetchByIdState({this.message, this.data});

  @override
  List<Object?> get props => [message, data];
}

@immutable
class FetchByIdDefault extends FetchByIdState {}

@immutable
class FetchByIdLoading extends FetchByIdState {}

@immutable
class FetchByIdSuccess extends FetchByIdState {
  const FetchByIdSuccess({required Product data}) : super(data: data);
}

@immutable
class FetchByIdFailed extends FetchByIdState {
  const FetchByIdFailed({super.message});
}
