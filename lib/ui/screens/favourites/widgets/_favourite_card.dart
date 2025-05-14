part of '../favourites.dart';

class FavoriteCard extends StatelessWidget {
  final Product product;
  final FavoriteProvider favoriteProvider;

  const FavoriteCard({
    super.key,
    required this.product,
    required this.favoriteProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppProps.favoriteCard,
      margin: Space.m.bottom.t16,
      child: Padding(
        padding: Space.p.all.t10,
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: product.images.first,
                  fit: BoxFit.cover,
                  placeholder:
                      (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Space.x.t12,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: AppText.t16 + FontWeight.w600,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Space.y.t04,
                  Text('\$${product.price}', style: AppText.t14),
                  Space.y.t04,
                  _buildRating(product.rating),
                ],
              ),
            ),

            IconButton(
              onPressed: () {
                favoriteProvider.removeFromFavorites(product);
              },
              icon: Image.asset(
                'assets/icon/favouriteFilled.png',
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRating(double rating) {
    return Row(
      children: [
        Text(rating.toString(), style: AppText.t14 + FontWeight.w600),
        Space.x.t04,
        Row(
          children: List.generate(
            5,
            (index) => Icon(
              Icons.star,
              size: 16,
              color:
                  index < rating.floor()
                      ? AppColors.yellow
                      : AppColors.inActive,
            ),
          ),
        ),
      ],
    );
  }
}
