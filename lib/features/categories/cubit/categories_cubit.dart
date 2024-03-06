import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/features/categories/data/repos/categories_repo.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepo _categoriesRepo;

  TextEditingController categoryNameController = TextEditingController();
  TextEditingController categoryColorController = TextEditingController();

  CategoriesCubit(this._categoriesRepo) : super(const CategoriesInitial());

  void loadCategories() {
    emit(const CategoriesLoading());
    try {
      final categories = _categoriesRepo.getCategories();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  double getCategoryTransactionsAmount(Category category) {
    final totalCategoryAmount =
        _categoriesRepo.getCategoryTransactionsAmount(category);
    return totalCategoryAmount;
  }

  int getCategoryTransactionsCount(Category category) {
    final totalCategoryCount =
        _categoriesRepo.getCategoryTransactionsCount(category);
    return totalCategoryCount;
  }

  List<int> get categoriesColorsValues =>
      _categoriesRepo.categoriesColors.values.toList();

  List<String> get categoriesColorsNames =>
      _categoriesRepo.categoriesColors.keys.toList();

  void emitCategoriesCreatingState() {
    emit(const CategoriesCreating());
  }

  void clearControllers() {
    categoryNameController.clear();
    categoryColorController.clear();
  }

  bool saveCategory() {
    if (categoryNameController.text.trim().isEmpty ||
        categoryColorController.text.trim().isEmpty) {
      emit(const CategoriesError('Please enter the category name'));
      return false;
    }

    final String categoryName = categoryNameController.text;
    final int categoryColor =
        _categoriesRepo.categoriesColors[categoryColorController.text]!;
    try {
      final newCategory =
          Category(name: categoryName, colorCode: categoryColor);
      _categoriesRepo.saveNewCategory(newCategory);
      emit(const CategoriesSaved());
      clearControllers();
      return true;
    } catch (e) {
      emit(CategoriesError(e.toString()));
      return false;
    }
  }
}
