part of '../product_detail.dart';

class _Dimensions extends StatelessWidget {
  final Product product;
  const _Dimensions({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dimensions', style: AppText.t18 + FontWeight.w600),
        Space.y.t15,
        Wrap(
          spacing: 20,
          runSpacing: 12,
          children: [
            _buildItem('Width', '${product.dimensions.width} cm'),
            _buildItem('Height', '${product.dimensions.height} cm'),
            _buildItem('Depth', '${product.dimensions.depth} cm'),
          ],
        ),
      ],
    );
  }

  Widget _buildItem(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.inActive[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppText.t12 + FontWeight.w600 + AppColors.inActive[600],
          ),
          Space.y.t04,
          Text(value, style: AppText.t14 + FontWeight.w500),
        ],
      ),
    );
  }
}
