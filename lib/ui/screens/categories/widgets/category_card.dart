part of '../categories.dart';

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String imagePath;

  const CategoryCard({
    super.key,
    required this.categoryName,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AppRoutes.categoryDetail.push(
          context,
          arguments: {'category': categoryName},
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  height: 120, // <- Set height instead of using Expanded
                  width: double.infinity,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: AppProps.categoryCard,
                  padding: Space.p.all.t08,
                  child: Text(
                    categoryName,
                    textAlign: TextAlign.center,
                    style: AppText.t14 + FontWeight.bold + AppColors.white,
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
