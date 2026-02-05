import 'package:smart_courier_assistant/core/state/form_status.dart';
import 'package:smart_courier_assistant/core/validator/user_validator.dart';
import 'package:smart_courier_assistant/domain/entity/user_entity.dart';

class EditProfileState {
  final UserEntity userEntity;
  final String errorMessage;
  final FormStatus formStatus;

  EditProfileState({
    required this.userEntity,
    required this.errorMessage,
    required this.formStatus,
  });

  factory EditProfileState.initial() {
    return EditProfileState(
      userEntity: UserEntity.initial(),
      errorMessage: '',
      formStatus: FormStatus.initial,
    );
  }

  EditProfileState copyWith({
    UserEntity? userEntity,
    String? errorMessage,
    FormStatus? formStatus,
  }) {
    return EditProfileState(
      userEntity: userEntity ?? this.userEntity,
      errorMessage: errorMessage ?? this.errorMessage,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  String? get fullNameError =>
      UserValidator.validateFullName(userEntity.fullName);

  String? get phoneNumberError =>
      UserValidator.validatePhoneNumber(userEntity.phoneNumber);
}
