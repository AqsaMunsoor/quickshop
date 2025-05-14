part of 'category_detail.dart';

class _ScreenState extends ChangeNotifier {
  _ScreenState({required Map<String, dynamic> args}) {
    category = args['category'] as String?;
  }
  // ignore: unused_element
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  String? category;

  Product? product;

  void setProduct(Product product) {
    this.product = product;

    notifyListeners();
  }
}
