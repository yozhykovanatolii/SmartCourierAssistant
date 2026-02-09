import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/exception/auth/user_not_found_exception.dart';
import 'package:smart_courier_assistant/core/exception/permission_deny_exception.dart';
import 'package:smart_courier_assistant/core/exception/photo_not_selected_exception.dart';
import 'package:smart_courier_assistant/core/state/form_status.dart';
import 'package:smart_courier_assistant/domain/entity/user_entity.dart';
import 'package:smart_courier_assistant/domain/repository/auth_repository.dart';
import 'package:smart_courier_assistant/domain/repository/user_repository.dart';
import 'package:smart_courier_assistant/presentation/bloc/edit_profile/edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final UserRepository userRepository;
  final AuthRepository authRepository;

  EditProfileCubit(this.userRepository, this.authRepository)
    : super(EditProfileState.initial());

  Future<void> editUserAvatar() async {
    try {
      final userAvatarUrl = await userRepository.getUserImage();
      final userEntity = state.userEntity;
      emit(
        state.copyWith(userEntity: userEntity.copyWith(avatar: userAvatarUrl)),
      );
    } on PermissionDenyException catch (exception) {
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
    final userEntity = state.userEntity;
    emit(state.copyWith(userEntity: userEntity.copyWith(fullName: fullName)));
  }

  void editUserPhoneNumber(String phoneNumber) {
    final userEntity = state.userEntity;
    emit(
      state.copyWith(userEntity: userEntity.copyWith(phoneNumber: phoneNumber)),
    );
  }

  void fetchUserProfile(UserEntity user) {
    emit(state.copyWith(userEntity: user));
  }

  Future<void> logOut() async => await authRepository.logOut();

  Future<void> updateProfile() async {
    emit(state.copyWith(formStatus: FormStatus.loading));
    try {
      await userRepository.updateUserData(state.userEntity);
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
