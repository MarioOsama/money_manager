part of 'categories_cubit.dart';

@immutable
abstract class CategoriesState {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {
  const CategoriesInitial();
}

class CategoriesLoading extends CategoriesState {
  const CategoriesLoading();
}

class CategoriesLoaded extends CategoriesState {
  final List<Category> categories;

  const CategoriesLoaded(this.categories);
}

class CategoriesError extends CategoriesState {
  final String message;

  const CategoriesError(this.message);
}
