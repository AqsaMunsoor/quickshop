part of '../favourites.dart';

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favorites = favoriteProvider.favorites;

    final displayedFavorites =
        _searchQuery.isEmpty
            ? favorites
            : favorites.where((product) {
              return product.title.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              );
            }).toList();

    return Screen(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      keyboardHandler: true,
      bottomBar: true,
      child: SafeArea(
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
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            Space.y.t08,
            Text(
              '${displayedFavorites.length} result${displayedFavorites.length == 1 ? '' : 's'} found',
              style: AppText.t16 + AppColors.inActive[600],
            ),
            Space.y.t10,
            if (displayedFavorites.isEmpty)
              const Expanded(
                child: Center(child: Text('No matching favorites found')),
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
