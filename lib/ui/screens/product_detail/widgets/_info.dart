part of '../product_detail.dart';

class _Info extends StatelessWidget {
  final Product product;
  const _Info({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildDetailItem('Name', product.title),
        _buildDetailItem('SKU', product.sku),

        Space.y.t10,
        Wrap(
          spacing: 20,
          runSpacing: 12,
          children: [
            _buildItem('Price', '\$${product.price.toStringAsFixed(2)}'),
            if (product.discountPercentage > 0)
              _buildItem('Discount', '${product.discountPercentage}% off'),
            _buildItem('Category', product.category),
            if (product.brand != null) _buildItem('Brand', product.brand!),
            _buildRatingItem(product.rating),
            _buildItem('Stock', '${product.stock}'),
            _buildItem('Weight', '${product.weight}g'),
          ],
        ),
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

  Widget _buildItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.inActive[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppText.t12 + FontWeight.w600 + AppColors.inActive[600],
          ),
          Space.y.t02,
          Text(value, style: AppText.t14 + FontWeight.w500),
        ],
      ),
    );
  }

  Widget _buildRatingItem(double rating) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.inActive[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rating',
            style: AppText.t12 + FontWeight.w600 + AppColors.inActive[600],
          ),
          Space.y.t02,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                rating.toStringAsFixed(1),
                style: AppText.t14 + FontWeight.w500,
              ),
              Space.x.t04,
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    Icons.star,
                    size: 14,
                    color:
                        index < rating.floor()
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
}
