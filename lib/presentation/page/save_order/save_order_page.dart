import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/util/ui_helper.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_state.dart';
import 'package:smart_courier_assistant/presentation/page/save_order/widget/address_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/save_order/widget/category_list_choice_section.dart';
import 'package:smart_courier_assistant/presentation/page/save_order/widget/client_full_name_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/save_order/widget/client_phone_number_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/save_order/widget/header_section.dart';
import 'package:smart_courier_assistant/presentation/page/save_order/widget/order_save_button.dart';

class SaveOrderPage extends StatelessWidget {
  const SaveOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SaveOrderCubit, SaveOrderState>(
      listener: (context, state) {
        if (state.formStatus == FormStatus.failure) {
          UiHelper.showSnackBar(
            context: context,
            message: state.errorMessage,
            isErrorSnackBar: true,
          );
        }
        if (state.formStatus == FormStatus.success) {
          UiHelper.showSnackBar(
            context: context,
            message: 'Success saving an order',
          );
          Navigator.of(context).pop();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(top: 103),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 3.5,
                  width: 50,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 10),
              const HeaderSection(),
              const SizedBox(height: 20),
              const Text(
                'Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              const AddressTextField(),
              const SizedBox(height: 20),
              const Text(
                'Client',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              const ClientFullNameTextField(),
              const SizedBox(height: 20),
              const Text(
                'Contact Phone',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              const ClientPhoneNumberTextField(),
              const SizedBox(height: 15),
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              const CategoryListChoiceSection(),
              const Expanded(
                child: Align(
                  alignment: AlignmentGeometry.bottomCenter,
                  child: OrderSaveButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
