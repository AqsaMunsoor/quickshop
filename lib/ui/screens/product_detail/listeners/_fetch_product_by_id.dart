part of '../product_detail.dart';

class _FetchProductByIdListener extends StatelessWidget {
  const _FetchProductByIdListener();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context);
    return BlocListener<ProductCubit, ProductState>(
      listenWhen: (a, b) => a.fetchById != b.fetchById,
      listener: (context, state) {
        if (state.fetchById is FetchByIdSuccess) {
          final product = state.fetchById.data!;
          screenState.setSession(product);
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
