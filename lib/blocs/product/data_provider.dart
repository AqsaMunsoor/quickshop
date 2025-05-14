part of 'cubit.dart';

class ProductProvider {
  Dio? localClient;
  ProductProvider({Dio? client}) : localClient = client;

  final Dio _dio = Dio();

  Future<ProductResponse> fetch() async {
    try {
      final response = await _dio.get(
        'https://dummyjson.com/products',
        queryParameters: {'limit': 194},
      );
      final raw = response.data as Map<String, dynamic>;
      return ProductResponse.fromJson(raw);
    } catch (e) {
      debugPrint('------ ProductProvider Error ------');
      debugPrint('------ $e ------');
      throw Exception("Failed to fetch products");
    }
  }

  Future<List<String>> fetchCategory() async {
    try {
      final response = await _dio.get(
        'https://dummyjson.com/products/category-list',
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }

      final List<dynamic> categoryNames = response.data as List<dynamic>;
      return categoryNames.map((name) => name.toString()).toList();
    } on DioException catch (e) {
      debugPrint('Category fetch error: ${e.message}');
      throw Exception('Failed to fetch categories: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error: $e');
      throw Exception('Failed to fetch categories');
    }
  }

  Future<Product> fetchById(String id) async {
    try {
      final response = await _dio.get('https://dummyjson.com/products/$id');

      final raw = response.data as Map<String, dynamic>;
      final product = Product.fromJson(raw);

      return product;
    } catch (e) {
      debugPrint('------ ProductProvider Error ------');
      debugPrint('------ $e ------');
      throw Exception("Failed to fetch product by ID");
    }
  }

  Future<List<Product>> searchProducts(String query) async {
    try {
      if (query.isEmpty) {
        return [];
      }

      final response = await _dio.get(
        'https://dummyjson.com/products/search',
        queryParameters: {'q': query},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to search products: ${response.statusCode}');
      }

      final raw = response.data as Map<String, dynamic>;
      final results = ProductResponse.fromJson(raw);
      return results.products;
    } on DioException catch (e) {
      debugPrint('Product search error: ${e.message}');
      throw Exception('Failed to search products: ${e.message}');
    } catch (e) {
      debugPrint('Unknown search error: $e');
      throw Exception('Failed to search products');
    }
  }

  Future<ProductResponse> fetchByCategory(String category) async {
    try {
      final response = await _dio.get(
        'https://dummyjson.com/products/category/$category',
      );
      final raw = response.data as Map<String, dynamic>;
      return ProductResponse.fromJson(raw);
    } catch (e) {
      debugPrint('------ ProductProvider Error ------');
      debugPrint('------ $e ------');
      throw Exception('Failed to fetch products by category');
    }
  }
}
