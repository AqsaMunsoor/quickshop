part of 'cubit.dart';

class ProductRepository {
  late final ProductProvider _dataLayer;
  ProductRepository({ProductProvider? productProvider})
    : _dataLayer = productProvider ?? ProductProvider();

  Future<ProductResponse> fetch() => _dataLayer.fetch();
  Future<List<String>> fetchCategory() => _dataLayer.fetchCategory();

  Future<Product> fetchById(String id) => _dataLayer.fetchById(id);

  Future<List<Product>> search(String query) async {
    return await _dataLayer.searchProducts(query);
  }


  Future<ProductResponse> fetchByCategory(String category) async {
    return await _dataLayer.fetchByCategory(category);
  }
}
