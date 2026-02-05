import 'package:smart_courier_assistant/core/state/form_status.dart';
import 'package:smart_courier_assistant/core/validator/user_validator.dart';

class EditProfileState {
  final String fullName;
  final String phoneNumber;
  final String userAvatar;
  final String errorMessage;
  final FormStatus formStatus;

  EditProfileState({
    required this.fullName,
    required this.phoneNumber,
    required this.userAvatar,
    required this.errorMessage,
    required this.formStatus,
  });

  factory EditProfileState.initial() {
    return EditProfileState(
      fullName: '',
      phoneNumber: '',
      userAvatar: '',
      errorMessage: '',
      formStatus: FormStatus.initial,
    );
  }

  EditProfileState copyWith({
    String? fullName,
    String? phoneNumber,
    String? userAvatar,
    String? errorMessage,
    FormStatus? formStatus,
  }) {
    return EditProfileState(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userAvatar: userAvatar ?? this.userAvatar,
      errorMessage: errorMessage ?? this.errorMessage,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  String? get fullNameError => UserValidator.validateFullName(fullName);

  String? get phoneNumberError =>
      UserValidator.validatePhoneNumber(phoneNumber);
}
