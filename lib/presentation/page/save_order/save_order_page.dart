import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/state/form_status.dart';
import 'package:smart_courier_assistant/core/util/ui/ui_helper.dart';
import 'package:smart_courier_assistant/domain/entity/order_entity.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_state.dart';
import 'package:smart_courier_assistant/presentation/page/save_order/widget/address_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/save_order/widget/category_list_choice_section.dart';
import 'package:smart_courier_assistant/presentation/page/save_order/widget/client_full_name_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/save_order/widget/client_phone_number_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/save_order/widget/header_section.dart';
import 'package:smart_courier_assistant/presentation/page/save_order/widget/order_delivery_time_section.dart';
import 'package:smart_courier_assistant/presentation/page/save_order/widget/order_save_button.dart';

class SaveOrderPage extends StatefulWidget {
  final OrderEntity? order;
  final bool isEditing;

  const SaveOrderPage({
    super.key,
    this.order,
    this.isEditing = false,
  });

  @override
  State<SaveOrderPage> createState() => _SaveOrderPageState();
}

class _SaveOrderPageState extends State<SaveOrderPage> {
  late final SaveOrderCubit cubit;
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _clientFullNameController =
      TextEditingController();
  final TextEditingController _clientPhoneNumberController =
      TextEditingController();

  @override
  void initState() {
    cubit = context.read<SaveOrderCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cubit.editOrder(widget.order);
      _addressController.text = widget.order?.address.name ?? '';
      _clientFullNameController.text = widget.order?.clientFullName ?? '';
      _clientPhoneNumberController.text = widget.order?.clientPhoneNumber ?? '';
    });
    super.initState();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _clientFullNameController.dispose();
    _clientPhoneNumberController.dispose();
    super.dispose();
  }

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
            message: S.of(context).successSavingAnOrder,
          );
          context.read<OrderCubit>().fetchOrders();
          Navigator.of(context).pop();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(top: 65),
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
              HeaderSection(
                isEditing: widget.isEditing,
              ),
              const SizedBox(height: 20),
              Text(
                S.of(context).address,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 5),
              AddressTextField(
                addressController: _addressController,
              ),
              const SizedBox(height: 20),
              Text(
                S.of(context).client,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 5),
              ClientFullNameTextField(
                clientFullNameController: _clientFullNameController,
              ),
              const SizedBox(height: 20),
              Text(
                S.of(context).contactPhone,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 5),
              ClientPhoneNumberTextField(
                clientPhoneNumberController: _clientPhoneNumberController,
              ),
              const SizedBox(height: 10),
              const OrderDeliveryTimeSection(),
              const SizedBox(height: 10),
              Text(
                S.of(context).category,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 5),
              const CategoryListChoiceSection(),
              Expanded(
                child: Align(
                  alignment: AlignmentGeometry.bottomCenter,
                  child: OrderSaveButton(
                    orderModel: widget.order,
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
