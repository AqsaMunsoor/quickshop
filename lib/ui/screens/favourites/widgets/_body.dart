part of '../favourites.dart';

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = FavoriteProvider.state(context);
    final favorites = favoriteProvider.favorites;

    final searchQuery = _searchController.text.toLowerCase();
    final displayedFavorites =
        searchQuery.isEmpty
            ? favorites
            : favorites.where((product) {
              return product.title.toLowerCase().contains(searchQuery);
            }).toList();

    return Screen(
      padding: Space.p.screen,
      keyboardHandler: true,
      bottomBar: true,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const AppHeader(title: 'Favourites', showBackButton: false),
                  Space.y.t20,
                  AppSearchTextInput(
                    hintText: 'Search in favorites...',
                    showPrefixIcon: true,
                    showNoteText: true,
                    onFieldSubmitted: (value) {
                      setState(() {});
                    },
                  ),

                  Space.y.t08,
                  Text(
                    '${displayedFavorites.length} result${displayedFavorites.length == 1 ? '' : 's'} found',
                    style: AppText.t16 + AppColors.inActive[600],
                  ),
                ],
              ),
            ),
            Space.y.t10,
            if (displayedFavorites.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    _searchController.text.isEmpty
                        ? 'No favorite products yet'
                        : 'No matching favorites found',
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: displayedFavorites.length,
                  itemBuilder: (context, index) {
                    final product = displayedFavorites[index];
                    return FavoriteCard(
                      product: product,
                      favoriteProvider: favoriteProvider,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
