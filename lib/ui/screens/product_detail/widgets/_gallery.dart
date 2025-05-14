
part of '../product_detail.dart';

class _Gallery extends StatelessWidget {
  final List<String> images;
  const _Gallery({required this.images});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Product Gallery', style: AppText.t18 + FontWeight.w600),
        Space.y.t12,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: images.length,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: images[index],
                fit: BoxFit.cover,
                alignment: Alignment.center,
                placeholder:
                    (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                errorWidget:
                    (context, url, error) => Container(
                      color: AppColors.inActive[200],
                      child: const Icon(Icons.error, color: Colors.red),
                    ),
              ),
            );
          },
        ),
      ],
    );
  }
}
