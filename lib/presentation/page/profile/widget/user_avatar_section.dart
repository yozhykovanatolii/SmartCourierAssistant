import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/constants/app_constant.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_bloc.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_state.dart';

class UserAvatarSection extends StatelessWidget {
  const UserAvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppBloc>().state;
    final ImageProvider<Object> avatarWidget = state is UserAuthenticatedState
        ? NetworkImage(state.user.avatar)
        : const AssetImage(AppConstant.defaultAvatar);
    return SizedBox(
      height: 120,
      width: 120,
      child: CircleAvatar(
        backgroundImage: avatarWidget,
      ),
    );
  }
}
