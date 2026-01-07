import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/data/model/user_model.dart';
import 'package:smart_courier_assistant/data/repository/auth_repository.dart';
import 'package:smart_courier_assistant/data/repository/user_repository.dart';
import 'package:smart_courier_assistant/presentation/bloc/edit_profile/edit_profile_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UserRepository userRepository = UserRepository();
  final AuthRepository authRepository = AuthRepository();

  EditProfileCubit() : super(EditProfileState.initial());

  Future<void> editUserAvatar() async {}

  void editUserFullName(String fullName) {
    emit(state.copyWith(fullName: fullName));
  }

  void editUserPhoneNumber(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void fetchUserProfile(UserModel user) {
    emit(
      state.copyWith(
        fullName: user.fullName,
        phoneNumber: user.phoneNumber,
        userAvatar: user.avatar,
      ),
    );
  }

  Future<void> updateProfile() async {
    emit(state.copyWith(formStatus: FormStatus.loading));
  }
}
