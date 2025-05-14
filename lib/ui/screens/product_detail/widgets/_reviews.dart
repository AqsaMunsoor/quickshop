part of '../product_detail.dart';

class _Reviews extends StatelessWidget {
  final Product product;

  const _Reviews({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Customer Reviews', style: AppText.t18 + FontWeight.w600),
        Space.y.t12,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: product.reviews.length,
          separatorBuilder: (context, index) => const Divider(height: 24),
          itemBuilder: (context, index) {
            final review = product.reviews[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: AppProps.review,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
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
                                AppText.t16 +
                                FontWeight.w600 +
                                AppColors.inActive[600],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Space.y.t12,

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
                  Container(
                    padding: Space.p.all.t10,
                    decoration: AppProps.comment,
                    child: Text(review.comment, style: AppText.t14),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
