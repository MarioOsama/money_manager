import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money_manager/core/models/transaction.dart';
import 'package:money_manager/features/categories/data/repos/categories_repo.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesRepo _categoriesRepo;

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
}
