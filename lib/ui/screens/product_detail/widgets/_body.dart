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
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Screen(
      padding: Space.p.vertical.t15,
      keyboardHandler: true,
      overlayBuilders: const [_FetchProductByIdListener()],
      child: SafeArea(
        child: BlocBuilder<ProductCubit, ProductState>(
          buildWhen:
              (previous, current) => previous.fetchById != current.fetchById,
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

            return _buildContent(product, favoriteProvider);
          },
        ),
      ),
    );
  }

  Widget _buildContent(Product product, FavoriteProvider favoriteProvider) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppHeader(title: 'Product Details'),
          Space.y.t20,
          _buildMainImage(product),
          Space.y.t20,
          _buildProductDetails(product, favoriteProvider),
          Space.y.t20,
          _buildDescription(product),
          Space.y.t20,
          _buildGallerySection(product),
          Space.y.t20,
          _buildReviewsSection(product),
        ],
      ),
    );
  }

  Widget _buildMainImage(Product product) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Image.network(product.images.first, fit: BoxFit.contain),
    );
  }

  Widget _buildProductDetails(
    Product product,
    FavoriteProvider favoriteProvider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Product Details:', style: AppText.t20 + FontWeight.w600),
            GestureDetector(
              onTap: () {
                favoriteProvider.toggleFavorite(product);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Image.asset(
                  favoriteProvider.isFavorite(product)
                      ? 'assets/icon/favouriteFilled.png'
                      : 'assets/icon/favouriteOutlined.png',
                  width: 24, // Adjust size as needed
                  height: 24, // Adjust size as needed
                ),
              ),
            ),
          ],
        ),
        Space.y.t15,
        _buildDetailItem('Name', product.title),
        _buildDetailItem('Price', '\$${product.price}'),
        _buildDetailItem('Category', product.category),
        _buildDetailItem('Brand', product.brand ?? 'N/A'),
        _buildRatingItem(
          'Rating',
          product.rating.toString(),
          product.rating.toInt(),
        ),
        _buildDetailItem('Stock', product.stock.toString()),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text('$label:', style: AppText.t16 + FontWeight.w600),
          Space.x.t08,
          Text(value, style: AppText.t14),
        ],
      ),
    );
  }

  Widget _buildRatingItem(String label, String value, int value2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text('$label:', style: AppText.t16 + FontWeight.w600),
          Space.x.t08,
          Row(
            children: [
              Text(value, style: AppText.t14),
              Space.x.t04,
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star,
                    size: 16,
                    color:
                        index < value2.floor()
                            ? AppColors.yellow
                            : AppColors.inActive,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: AppText.t18 + FontWeight.w600),
        Space.y.t08,
        Text(product.description, style: AppText.t14),
      ],
    );
  }

  Widget _buildGallerySection(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Product Gallery', style: AppText.t18 + FontWeight.w600),
        Space.y.t12,
        _buildImageGrid(product.images),
      ],
    );
  }

  Widget _buildImageGrid(List<String> images) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) => _buildGalleryImage(images[index]),
    );
  }

  Widget _buildGalleryImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        placeholder:
            (context, url) => const Center(child: CircularProgressIndicator()),
        errorWidget:
            (context, url, error) => Container(
              color: AppColors.inActive[200],
              child: const Icon(Icons.error, color: Colors.red),
            ),
      ),
    );
  }

  Widget _buildReviewsSection(Product product) {
    if (product.reviews.isEmpty) {
      return const SizedBox.shrink(); // Return empty if no reviews
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Customer Reviews', style: AppText.t18 + FontWeight.w600),
        Space.y.t12,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: product.reviews.length,
          separatorBuilder: (context, index) => const Divider(height: 24),
          itemBuilder:
              (context, index) => _buildReviewItem(product.reviews[index]),
        ),
      ],
    );
  }

  Widget _buildReviewItem(Review review) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: AppProps.review,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar or Initials
              CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.inActive,
                child: Text(
                  review.reviewerName.isNotEmpty
                      ? review.reviewerName[0].toUpperCase()
                      : '?',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
              ),
              Space.x.t12,
              // Name and date
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.reviewerName,
                    style: AppText.t14 + FontWeight.w600,
                  ),
                  Space.y.t02,
                  Text(
                    review.date.dateTimeWords,
                    style:
                        AppText.t16 + FontWeight.w600 + AppColors.inActive[600],
                  ),
                ],
              ),
            ],
          ),
          Space.y.t12,
          // Rating stars
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star_rounded,
                size: 20,
                color:
                    index < review.rating
                        ? AppColors.yellow
                        : AppColors.inActive,
              ),
            ),
          ),
          Space.y.t08,
          // Comment box
          Container(
            padding: Space.p.all.t10,
            decoration: AppProps.comment,
            child: Text(review.comment, style: AppText.t14),
          ),
        ],
      ),
    );
  }
}
