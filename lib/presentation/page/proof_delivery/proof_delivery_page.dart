import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/util/ui_helper.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/proof_delivery/proof_delivery_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/proof_delivery/proof_delivery_state.dart';
import 'package:smart_courier_assistant/presentation/page/proof_delivery/widget/comment_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/proof_delivery/widget/confirm_button.dart';
import 'package:smart_courier_assistant/presentation/page/proof_delivery/widget/header_proof_delivery.dart';
import 'package:smart_courier_assistant/presentation/page/proof_delivery/widget/photo_list_view.dart';

class ProofDeliveryPage extends StatelessWidget {
  final String orderId;

  const ProofDeliveryPage({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProofDeliveryCubit, ProofDeliveryState>(
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
            message: S.of(context).successConfirmingADelivery,
          );
          Navigator.of(context).pop();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(top: 175),
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
              const HeaderProofDelivery(),
              const SizedBox(height: 20),
              Text(
                S.of(context).comment,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 5),
              const CommentTextField(),
              const SizedBox(height: 20),
              Text(
                S.of(context).photo,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                S.of(context).takeSeveralPhotosOfYourOrderAndSelectFromThe,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 15),
              const PhotoListView(),
              Expanded(
                child: Align(
                  alignment: AlignmentGeometry.bottomCenter,
                  child: ConfirmButton(orderId: orderId),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
