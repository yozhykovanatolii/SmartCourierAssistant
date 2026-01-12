import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/presentation/bloc/login/login_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_state.dart';

class SaveOrderCubit extends Cubit<SaveOrderState> {
  SaveOrderCubit() : super(SaveOrderState.initial());

  void setOrderAddress(String address) {
    emit(state.copyWith(address: address));
  }

  void setClientFullName(String clientFullName) {
    emit(state.copyWith(clientFullName: clientFullName));
  }

  void setClientPhoneNumber(String clientPhoneNumber) {
    emit(state.copyWith(clientPhoneNumber: clientPhoneNumber));
  }

  void chooseOrderCategory(String category) {
    final previousCategory = state.category;
    if (category == previousCategory) return;
    emit(state.copyWith(category: category));
  }

  void saveOrder() {
    emit(state.copyWith(formStatus: FormStatus.loading));
  }
}
