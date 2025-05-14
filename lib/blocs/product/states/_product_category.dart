part of '../cubit.dart';

@immutable
class ProductCategoryState extends Equatable {
  static bool match(ProductState a, ProductState b) =>
      a.fetchByCategory != b.fetchByCategory;

  final List<Product>? products;
  final String? category;
  final String? message;

  const ProductCategoryState({this.products, this.category, this.message});

  @override
  List<Object?> get props => [products, category, message];
}

@immutable
class ProductCategoryInitial extends ProductCategoryState {
  const ProductCategoryInitial();
}

@immutable
class ProductCategoryLoading extends ProductCategoryState {
  const ProductCategoryLoading({required String category})
    : super(category: category);
}

@immutable
class ProductCategorySuccess extends ProductCategoryState {
  const ProductCategorySuccess({
    required List<Product> products,
    required String category,
  }) : super(products: products, category: category);
}

@immutable
class ProductCategoryFailed extends ProductCategoryState {
  const ProductCategoryFailed({
    required String message,
    required String category,
  }) : super(message: message, category: category);
}
