part of '../product_detail.dart';

class _Meta extends StatelessWidget {
  final Product product;
  const _Meta({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Product Meta data', style: AppText.t18 + FontWeight.w600),
        Space.y.t08,
        _buildDetailItem('Created', product.meta.createdAt.dateTimeWords),
        _buildDetailItem('Last Updated', product.meta.updatedAt.dateTimeWords),
        _buildDetailItem('Barcode', product.meta.barcode),
        _buildQrCodeItem('QR Code', product.meta.qrCode),
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

  Widget _buildQrCodeItem(String label, String qrCodeUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label:', style: AppText.t16 + FontWeight.w600),
          Space.y.t08,
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.inActive),
              borderRadius: BorderRadius.circular(8),
            ),
            child: CachedNetworkImage(
              imageUrl: qrCodeUrl,
              fit: BoxFit.cover,
              placeholder:
                  (context, url) =>
                      const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ],
      ),
    );
  }
}
