part of '../product_detail.dart';

class ProductDetails extends StatelessWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = FavoriteProvider.state(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Image.network(product.images.first, fit: BoxFit.contain),
        ),
        Space.y.t20,
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
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ],
        ),
        Space.y.t15,
        _Info(product: product),
        Space.y.t20,
        _Dimensions(product: product),
        Space.y.t20,
        _Policies(product: product),
        Space.y.t20,
        Text('Description', style: AppText.t18 + FontWeight.w600),
        Space.y.t08,
        Text(product.description, style: AppText.t14),
        Space.y.t20,

        _Meta(product: product),
        Space.y.t20,
        _Gallery(images: product.images),
        Space.y.t20,
        _Reviews(product: product),
      ],
    );
  }
}
