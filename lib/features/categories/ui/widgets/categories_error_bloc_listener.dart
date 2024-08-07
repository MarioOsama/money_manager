import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/features/categories/logic/cubit/categories_cubit.dart';

class CategoriesErrorBlocListener extends StatelessWidget {
  const CategoriesErrorBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoriesCubit, CategoriesState>(
      listener: (BuildContext context, state) {
        if (state is CategoriesError) {
          context.clearSnackBar();
          context.showSnackBar(
            message: state.message,
            textStyle: TextStyles.f14WhiteSemiBold.copyWith(
                fontSize: TextStyles.getResponsiveFontSize(context,
                    baseFontSize: 14)),
          );
        }
      },
      child: const SizedBox.shrink(),
    );
  }
}
