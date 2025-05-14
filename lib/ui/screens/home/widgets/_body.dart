part of '../home.dart';

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _scrollController = ScrollController();
  final _searchController = TextEditingController();

  bool _hasFetched = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productCubit = ProductCubit.c(context);
      if (!_hasFetched && productCubit.state.displayedProducts.isEmpty) {
        productCubit.fetch();
        _hasFetched = true;
      }
    });
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final productCubit = ProductCubit.c(context);
      if (productCubit.state.search is! ProductSearchSuccess &&
          productCubit.state.search is! ProductSearchLoading) {
        productCubit.loadMoreProducts();
      }
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
    final productCubit = ProductCubit.c(context, true);

    return Screen(
      padding: Space.p.screen,
      keyboardHandler: true,
      bottomBar: true,
      child: SafeArea(
        child: FormBuilder(
          key: screenState.formKey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ignore: prefer_const_constructors
                  AppHeader(title: 'Products', showBackButton: false),
                  Space.y.t20,
                  AppSearchTextInput(
                    controller: _searchController,
                    hintText: 'Search for products in ...',
                    onFieldSubmitted: (value) {
                      if (value.isEmpty) {
                        productCubit.resetSearch();
                      } else {
                        productCubit.searchProducts(value);
                      }
                    },
                    onClear: () {
                      productCubit.resetSearch();
                    },
                  ),
                  Space.y.t06,
                ],
              ),
              // Main content area
              Expanded(
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    final productsToDisplay = state.displayedProducts;
                    final isSearching =
                        state.search is ProductSearchSuccess ||
                        state.search is ProductSearchLoading;
                    final isLoadingSearchResults =
                        state.search is ProductSearchLoading;
                    final isLoadingInitialData =
                        state.fetch is ProductFetchLoading &&
                        productsToDisplay.isEmpty;

                    if (isLoadingInitialData ||
                        (isLoadingSearchResults && productsToDisplay.isEmpty)) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state.fetch is ProductFetchFailed &&
                        productsToDisplay.isEmpty &&
                        !isSearching) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Failed to load products.'),
                            Space.y.t10,
                            ElevatedButton(
                              onPressed: () => productCubit.fetch(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    }

                    if (productsToDisplay.isEmpty) {
                      return Center(
                        child: Text(
                          isSearching && state.search is! ProductSearchLoading
                              ? 'No matching products found'
                              : 'No products available',
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            isSearching
                                ? '${productsToDisplay.length} search results found'
                                : '${productsToDisplay.length} results found.',
                            style: AppText.t12 + AppColors.lightBlack,
                          ),
                        ),
                        Space.y.t10,
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 60),
                            controller: _scrollController,
                            itemCount:
                                productsToDisplay.length +
                                (state.isLoadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index >= productsToDisplay.length) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              final product = productsToDisplay[index];
                              return ProductCard(product: product);
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
