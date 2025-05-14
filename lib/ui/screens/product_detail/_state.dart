part of 'product_detail.dart';

class _ScreenState extends ChangeNotifier {
  _ScreenState({required Map<String, dynamic> args}) {
    
    final dynamic id = args['productId'];
    productId = id is int ? id.toString() : id as String;
  }
  //unused element
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);
  String? productId;

  Product? product;

  void setSession(Product product) {
    this.product = product;

    notifyListeners();
  }
}
