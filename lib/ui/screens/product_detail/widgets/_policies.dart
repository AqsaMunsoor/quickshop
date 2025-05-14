part of '../product_detail.dart';

class _Policies extends StatelessWidget {
  final Product product;
  const _Policies({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Policies', style: AppText.t18 + FontWeight.w600),
        Space.y.t15,
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildItem('Warranty', product.warrantyInformation),
              Space.x.t20,
              _buildItem('Shipping', product.shippingInformation),
              Space.x.t20,
              _buildItem('Return', product.returnPolicy),
              Space.x.t20,
              _buildItem('Availability', product.availabilityStatus),
              Space.x.t20,
              _buildItem('Min Qty', product.minimumOrderQuantity.toString()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItem(String label, String value) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
            textAlign: TextAlign.center,
          ),
          Space.y.t04,
          Text(
            value,
            style: AppText.t14 + FontWeight.w500,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
