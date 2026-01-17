import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/exception/auth/user_not_found_exception.dart';
import 'package:smart_courier_assistant/core/exception/permission_denied_exception.dart';
import 'package:smart_courier_assistant/core/exception/photo_not_selected_exception.dart';
import 'package:smart_courier_assistant/data/model/user_model.dart';
import 'package:smart_courier_assistant/data/repository/auth_repository.dart';
import 'package:smart_courier_assistant/data/repository/user_repository.dart';
import 'package:smart_courier_assistant/presentation/bloc/edit_profile/edit_profile_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UserRepository _userRepository = UserRepository();
  final AuthRepository _authRepository = AuthRepository();

  EditProfileCubit() : super(EditProfileState.initial());

  Future<void> editUserAvatar() async {
    try {
      final userAvatarUrl = await _userRepository.getUserImage();
      emit(state.copyWith(userAvatar: userAvatarUrl));
    } on PermissionDeniedException catch (exception) {
      emit(
        state.copyWith(
          errorMessage: exception.errorMessage,
          formStatus: FormStatus.failure,
        ),
      );
    } on PhotoNotSelectedException catch (exception) {
      emit(
        state.copyWith(
          errorMessage: exception.errorMessage,
          formStatus: FormStatus.failure,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          errorMessage: '',
          formStatus: FormStatus.initial,
        ),
      );
    }
  }

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

  Future<void> logOut() async => await _authRepository.logOut();

  Future<void> updateProfile() async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      await _userRepository.updateUserData(
        state.userAvatar,
        state.fullName,
        state.phoneNumber,
      );
      emit(state.copyWith(formStatus: FormStatus.success));
    } on UserNotFoundException catch (exception) {
      emit(
        state.copyWith(
          errorMessage: exception.errorMessage,
          formStatus: FormStatus.success,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          errorMessage: '',
          formStatus: FormStatus.initial,
        ),
      );
    }
  }
}
