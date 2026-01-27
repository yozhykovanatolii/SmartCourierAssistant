import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/util/ui_helper.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/proof_delivery/proof_delivery_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/proof_delivery/proof_delivery_state.dart';
import 'package:smart_courier_assistant/presentation/page/proof_delivery/widget/comment_text_field.dart';
import 'package:smart_courier_assistant/presentation/page/proof_delivery/widget/confirm_button.dart';
import 'package:smart_courier_assistant/presentation/page/proof_delivery/widget/header_proof_delivery.dart';
import 'package:smart_courier_assistant/presentation/page/proof_delivery/widget/photo_list_view.dart';

class ProofDeliveryPage extends StatelessWidget {
  const ProofDeliveryPage({super.key});

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
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        margin: const EdgeInsets.only(top: 175),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
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
              const Text(
                'Comment📝',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              const CommentTextField(),
              const SizedBox(height: 20),
              const Text(
                'Photo📸',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              const PhotoListView(),
              const Expanded(
                child: Align(
                  alignment: AlignmentGeometry.bottomCenter,
                  child: ConfirmButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
