import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:money_manager/core/helpers/extensions.dart';
import 'package:money_manager/core/helpers/spacing.dart';
import 'package:money_manager/core/logic/cubit/bank_card_cubit.dart';
import 'package:money_manager/core/theming/colors.dart';
import 'package:money_manager/core/theming/text_styles.dart';
import 'package:money_manager/core/widgets/animated_bank_card_container.dart';
import 'package:money_manager/features/transaction/logic/cubit/transaction_cubit.dart';
import 'package:money_manager/features/transaction/ui/widgets/drop_down_menu_items_row.dart';
import 'package:money_manager/features/transaction/ui/widgets/attachment_picker_container.dart';
import 'package:money_manager/features/transaction/ui/widgets/save_transaction_button.dart';
import 'package:money_manager/features/transaction/ui/widgets/text_fields_group.dart';
import 'package:money_manager/features/transaction/ui/widgets/transaction_error_bloc_listener.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionCubit = context.read<TransactionCubit>();
    final bankCardCubit = context.read<BankCardCubit>();
    transactionCubit.setupTransactionControllers();

    return PopScope(
      onPopInvoked: (didPop) {
        bankCardCubit.getBankCardData();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'New Transaction',
            style: TextStyles.f23WhiteRegular,
            textAlign: TextAlign.center,
          ),
          surfaceTintColor: AppColors.primaryDarkColor,
          backgroundColor: AppColors.cyanColor,
          iconTheme: const IconThemeData(
            size: 30,
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const AnimatedBankCardContainer(
                padding: EdgeInsets.fromLTRB(12, 0, 12, 10),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 30.h),
                child: Form(
                  key: context.read<TransactionCubit>().formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpace(20),
                      const DropDownMenuItemsRow(),
                      const TextFieldsGroup(),
                      verticalSpace(20),
                      const AttachmentPickerContainer(),
                      verticalSpace(35),
                      const SaveTransactionButton(),
                      const TransactionErrorBlocListener(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
