part of 'categories.dart';

class _ScreenState extends ChangeNotifier {
  // ignore: unused_element
  static _ScreenState s(BuildContext context, [listen = false]) =>
      Provider.of<_ScreenState>(context, listen: listen);

  final formKey = GlobalKey<FormBuilderState>();

  String _searchQuery = '';
  List<String>? _filteredCategories;

  String get searchQuery => _searchQuery;
  List<String>? get filteredCategories => _filteredCategories;

  void setSearchQuery(String query, List<String> allCategories) {
    _searchQuery = query.toLowerCase();

    if (_searchQuery.isEmpty) {
      _filteredCategories = null;
    } else {
      _filteredCategories =
          allCategories
              .where(
                (category) => category.toLowerCase().contains(_searchQuery),
              )
              .toList();
    }

    notifyListeners();
  }
}
