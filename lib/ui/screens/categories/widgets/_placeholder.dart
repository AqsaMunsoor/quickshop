part of '../categories.dart';

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        itemCount: 10,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 60),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 18,
          crossAxisSpacing: 18,
          childAspectRatio: 3 / 2.5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return CategoryCardShimmer();
        },
      ),
    );
  }
}
