part of '../category_detail.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    super.key,
    required ScrollController scrollController,
    required this.context,
    required this.state,
    required this.products,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final BuildContext context;
  final ProductState state;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    final productCubit = ProductCubit.c(context);
    final isLoading = state.fetchByCategory is ProductCategoryLoading;
    final isFailed = state.fetchByCategory is ProductCategoryFailed;

    if (isLoading && products.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (isFailed) {
      final error = state.fetchByCategory as ProductCategoryFailed;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Error: ${error.message}'),
            Space.y.t15,
            ElevatedButton(
              onPressed: () => productCubit.fetchByCategory(error.category!),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (products.isEmpty) {
      return const Center(child: Text('No products found in this category'));
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 60),
      itemCount: products.length + (state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= products.length) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final product = products[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ProductCard(product: product),
        );
      },
    );
  }
}
