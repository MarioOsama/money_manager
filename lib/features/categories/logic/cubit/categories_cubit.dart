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
    final String categoryName = categoryNameController.text.trim();
    if (categoryName.isEmpty) {
      emit(
          const CategoriesError('Saving failed, please enter a category name'));
      return false;
    }
    final List<String> categoryNameFragments = categoryName.split(' ');
    final String capitalizedCategoryName =
        capitalizeCategoryName(categoryNameFragments);
    final categoriesColors = _categoriesRepo.categoriesColors;
    final int categoryColor = categoriesColors[categoryColorController.text]!;
    if (isCategoryExists(capitalizedCategoryName)) {
      emit(const CategoriesError('Category already exists'));
      return false;
    }
    try {
      final newCategory =
          Category(name: capitalizedCategoryName, colorCode: categoryColor);
      _categoriesRepo.saveNewCategory(newCategory);
      emit(const CategoriesSaved());
      clearControllers();
      return true;
    } catch (e) {
      emit(CategoriesError(e.toString()));
      return false;
    }
  }

  String capitalizeCategoryName(List<String> categoryNameFragments) {
    String capitalizedCategoryName = '';
    for (var fragment in categoryNameFragments) {
      capitalizedCategoryName +=
          '${fragment[0].toUpperCase() + fragment.substring(1)} ';
    }
    return capitalizedCategoryName.trim();
  }

  bool isCategoryExists(String categoryName) {
    final isCategoryExists = _categoriesRepo.isCategoryExists(categoryName);
    return isCategoryExists;
  }

  void deleteCategory(String categoryName) {
    _categoriesRepo.deleteCategoryAndItsTransactionFromDatabase(categoryName);
  }

  void toggleCategorySelection(String selectedCategory) {
    emitCategoriesSelectedState();
    final List<String>? updatedSelectedCategoriesList =
        updateSelectedCategoriesList(selectedCategory);
    if (updatedSelectedCategoriesList != null) {
      emit(CategoriesSelected(updatedSelectedCategoriesList));
    }
  }

  void emitCategoriesSelectedState() {
    if (state is CategoriesSelected) {
      final List<String> selectedCategories =
          (state as CategoriesSelected).listOfSelectedCategories;
      emit(CategoriesSelected(selectedCategories));
      return;
    }
    emit(const CategoriesSelected([]));
  }

  List<String>? updateSelectedCategoriesList(String selectedCategory) {
    if (state is CategoriesSelected) {
      final List<String> currentSelectedCategories =
          (state as CategoriesSelected).listOfSelectedCategories;
      final bool isSelected =
          currentSelectedCategories.contains(selectedCategory);
      if (isSelected) {
        currentSelectedCategories.remove(selectedCategory);
        if (currentSelectedCategories.isEmpty) {
          emit(const CategoriesSelected([]));
        }
        return currentSelectedCategories;
      }
      final List<String> updatedSelectedCategories = [
        selectedCategory,
        ...currentSelectedCategories
      ];
      return updatedSelectedCategories;
    }
    return null;
  }

  void setupCategoryControllers() {
    categoryColorController.text = categoriesColorsNames.first;
  }
}
