part of '../product_detail.dart';

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  bool _hasFetched = false;

  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }

  void _fetchProduct() {
    if (_hasFetched) return;

    final screenState = _ScreenState.s(context);
    final productCubit = ProductCubit.c(context);

    if (screenState.productId != null && screenState.product == null) {
      _hasFetched = true;
      productCubit.fetchById(screenState.productId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);
    final product = screenState.product;

    return Screen(
      padding: Space.p.vertical.t15,
      keyboardHandler: true,
      overlayBuilders: const [_FetchProductByIdListener()],
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const AppHeader(title: 'Product Details'),
              Space.y.t20,
              BlocBuilder<ProductCubit, ProductState>(
                buildWhen:
                    (previous, current) =>
                        previous.fetchById != current.fetchById,
                builder: (context, state) {
                  if (state.fetchById is FetchByIdLoading && product == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.fetchById is FetchByIdFailed) {
                    return const Center(child: Text('Failed to load product'));
                  }

                  if (product == null) {
                    return const Center(child: Text('Product not found'));
                  }

                  return ProductDetails(product: product);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
