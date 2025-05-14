part of '../categories.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final screenState = _ScreenState.s(context, true);
    final productCubit = ProductCubit.c(context, true);
    final fetchCategoryState = productCubit.state.fetchCategory;

    final isLoading = fetchCategoryState is CategoryFetchLoading;
    final isSuccess = fetchCategoryState is CategoryFetchSuccess;
    final isFailed = fetchCategoryState is CategoryFetchFailed;

    final allCategories = productCubit.state.categories ?? [];
    final displayedCategories = screenState.filteredCategories ?? allCategories;

    return Screen(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      keyboardHandler: true,
      bottomBar: true,
      child: SafeArea(
        child: FormBuilder(
          key: screenState.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppHeader(title: 'Categories', showBackButton: false),
              Space.y.t20,
              AppSearchTextInput(
                hintText: 'Search for categories...',
                onFieldSubmitted: (value) {
                  screenState.setSearchQuery(value, allCategories);
                },
              ),
              Space.y.t10,
              if (isSuccess && displayedCategories.isNotEmpty)
                Text('${displayedCategories.length} results found:'),
              Space.y.t20,
              if (isLoading)
                const _Placeholder()
              else if (isFailed)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Failed to load products.'),
                        Space.y.t10,
                        AppButton(
                          label: 'Retry',
                          onPressed: () {
                            productCubit.fetchCategory();
                          },
                        ),
                      ],
                    ),
                  ),
                )
              else if (displayedCategories.isEmpty && isSuccess)
                const Expanded(
                  child: Center(child: Text('No categories found.')),
                )
              else
                Expanded(
                  child: GridView.builder(
                    itemCount: displayedCategories.length,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 60),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 18,
                          crossAxisSpacing: 18,
                          childAspectRatio: 3 / 2.5,
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      final category = displayedCategories[index];
                      final imagePath =
                          categoryImages[index % categoryImages.length];

                      return CategoryCard(
                        categoryName: category.titleCase,
                        imagePath: imagePath,
                      );
                    },
                  ),
                ),

              Space.y.t20,
            ],
          ),
        ),
      ),
    );
  }
}
