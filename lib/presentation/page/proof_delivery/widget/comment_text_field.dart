import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/localization/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/proof_delivery/proof_delivery_cubit.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final courierCommentCount = context.select(
      (ProofDeliveryCubit cubit) => cubit.state.courierCommentCount,
    );
    final courierCommentError = context.select(
      (ProofDeliveryCubit cubit) => cubit.state.courierCommentError,
    );
    return SizedBox(
      height: 100,
      child: TextField(
        maxLines: null,
        minLines: 5,
        onChanged: (comment) =>
            context.read<ProofDeliveryCubit>().editCourierComment(comment),
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF6F6F6),
          hintText: S.of(context).enterComment,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
          contentPadding: const EdgeInsets.all(10),
          counterText: courierCommentCount,
          errorText: courierCommentError,
        ),
      ),
    );
  }
}
