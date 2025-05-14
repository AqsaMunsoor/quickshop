part of '../category_detail.dart';

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    final screenState = _ScreenState.s(context);
    if (screenState.category != null) {
      ProductCubit.c(context).fetchByCategory(screenState.category!);
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final productCubit = ProductCubit.c(context);
      productCubit.loadMoreProducts();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);
    final category = screenState.category;

    return Screen(
      padding: const EdgeInsets.symmetric(vertical: 15),
      keyboardHandler: true,
      bottomBar: true,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppHeader(title: category?.titleCase ?? 'Category'),
            Space.y.t20,
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                buildWhen: (previous, current) {
                  return previous.fetchByCategory != current.fetchByCategory ||
                      previous.isLoadingMore != current.isLoadingMore;
                },
                builder: (context, state) {
                  final isLoading =
                      state.fetchByCategory is ProductCategoryLoading;
                  final isSuccess =
                      state.fetchByCategory is ProductCategorySuccess;
                  final isFailed =
                      state.fetchByCategory is ProductCategoryFailed;
                  final products = state.fetchByCategory.products ?? [];

                  if (isSuccess || isLoading) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            '${products.length} products found',
                            style: AppText.t14 + AppColors.inActive,
                          ),
                        ),
                        Space.y.t10,
                        Expanded(
                          child: ProductList(
                            scrollController: _scrollController,
                            context: context,
                            state: state,
                            products: products,
                          ),
                        ),
                      ],
                    );
                  } else if (isFailed) {
                    return Text(
                      'Failed to fetch category detail',
                      style: AppText.t14,
                    );
                  }

                  return ProductList(
                    scrollController: _scrollController,
                    context: context,
                    state: state,
                    products: products,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
