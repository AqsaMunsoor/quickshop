import 'dart:async';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quickshop/models/product/product.dart';
import 'package:quickshop/models/product_response/product_response.dart';

part 'data_provider.dart';
part 'mocks.dart';
part 'repository.dart';
part 'state.dart';
part 'states/_fetch_all.dart';
part 'states/_fetch_by_id.dart';
part 'states/_fetch_category.dart';
part 'states/_product_category.dart';
part 'states/_search_product.dart';

class ProductCubit extends Cubit<ProductState> {
  static ProductCubit c(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<ProductCubit>(context, listen: listen);
  ProductCubit({ProductRepository? repository})
    : _repo = repository ?? ProductRepository(),
      super(const ProductStateDefault());

  late final ProductRepository _repo;

  Future<void> fetch({bool emitLoading = true}) async {
    if (emitLoading) {
      emit(
        state.copyWith(
          fetch: ProductFetchLoading(),
          displayedProducts: [],
          allProducts: [],
          currentPage: 1,
          hasReachedMax: false,
          isLoadingMore: false,
          search: ProductSearchInitial(),
        ),
      );
    }

    try {
      final dataFromApi = await _repo.fetch();
      final allFetchedProducts = dataFromApi.products;

      final initialDisplayProducts =
          allFetchedProducts.take(ProductState.itemsPerPage).toList();

      emit(
        state.copyWith(
          fetch: ProductFetchSuccess(data: dataFromApi),
          allProducts: allFetchedProducts,
          displayedProducts: initialDisplayProducts,
          currentPage: 1,
          hasReachedMax:
              initialDisplayProducts.length == allFetchedProducts.length,
          isLoadingMore: false,
        ),
      );
    } catch (e) {
      emit(state.copyWith(fetch: ProductFetchFailed(message: e.toString())));
    }
  }

  void loadMoreProducts() {
    if (state.isLoadingMore ||
        state.hasReachedMax ||
        state.search is ProductSearchSuccess ||
        state.search is ProductSearchLoading) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));

    Future.delayed(const Duration(milliseconds: 500), () {
      final nextPage = state.currentPage + 1;
      final currentTotalDisplayed = state.displayedProducts.length;

      final newProducts =
          state.allProducts!
              .skip(currentTotalDisplayed)
              .take(ProductState.itemsPerPage)
              .toList();

      if (newProducts.isEmpty) {
        emit(state.copyWith(hasReachedMax: true, isLoadingMore: false));
      } else {
        emit(
          state.copyWith(
            displayedProducts: List.of(state.displayedProducts)
              ..addAll(newProducts),
            currentPage: nextPage,
            isLoadingMore: false,
            hasReachedMax:
                (currentTotalDisplayed + newProducts.length) ==
                state.allProducts!.length,
          ),
        );
      }
    });
  }

  Future<void> searchProducts(String query) async {
    emit(state.copyWith(search: ProductSearchLoading(query: query)));

    final normalizedQuery = query.toLowerCase();

    final results =
        state.displayedProducts
            .where(
              (product) =>
                  (product.title.toLowerCase().contains(normalizedQuery)) ||
                  (product.description.toLowerCase().contains(
                    normalizedQuery,
                  )) ||
                  (product.category.toLowerCase().contains(normalizedQuery)),
            )
            .toList();

    emit(
      state.copyWith(
        search: ProductSearchSuccess(results: results, query: query),

        displayedProducts: results,

        hasReachedMax: true,
        isLoadingMore: false,
      ),
    );
  }

  void resetSearch() {
    final productsToShowAfterReset =
        state.allProducts!
            .take(ProductState.itemsPerPage * state.currentPage)
            .toList();

    emit(
      state.copyWith(
        search: ProductSearchInitial(),
        displayedProducts: productsToShowAfterReset,
        hasReachedMax:
            productsToShowAfterReset.length == state.allProducts!.length,
        isLoadingMore: false,
      ),
    );
  }

  Future<void> fetchCategory({bool emitLoading = true}) async {
    if (emitLoading) {
      emit(state.copyWith(fetchCategory: CategoryFetchLoading()));
    }

    try {
      final categories = await _repo.fetchCategory();
      emit(
        state.copyWith(
          fetchCategory: CategoryFetchSuccess(data: categories),
          categories: categories,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          fetchCategory: CategoryFetchFailed(message: e.toString()),
        ),
      );
    }
  }

  Future<Product>? fetchById(String productId) async {
    emit(state.copyWith(fetchById: FetchByIdLoading()));

    try {
      final data = await _repo.fetchById(productId);

      emit(state.copyWith(fetchById: FetchByIdSuccess(data: data)));
      return data;
    } catch (e) {
      emit(state.copyWith(fetchById: FetchByIdFailed(message: e.toString())));
      rethrow;
    }
  }

  Future<void> fetchByCategory(String category) async {
    emit(
      state.copyWith(
        fetchByCategory: ProductCategoryLoading(category: category),
      ),
    );

    try {
      final response = await _repo.fetchByCategory(category);
      emit(
        state.copyWith(
          fetchByCategory: ProductCategorySuccess(
            products: response.products,
            category: category,
          ),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          fetchByCategory: ProductCategoryFailed(
            message: e.toString(),
            category: category,
          ),
        ),
      );
    }
  }
}
