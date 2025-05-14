part of '../home.dart';

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 60),

      itemCount: 15,
      itemBuilder: (context, index) {
        return ProductCardShimmer();
      },
    );
  }
}
