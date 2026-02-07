import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_courier_assistant/core/util/ui/ui_helper.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_bloc.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_state.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/action_floating_button.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/google_map_section.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/orders_draggable_sheet.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/route_optimization_dialog.dart';
import 'package:smart_courier_assistant/presentation/page/login/login_page.dart';
import 'package:smart_courier_assistant/presentation/page/profile/profile_page.dart';
import 'package:smart_courier_assistant/presentation/page/save_order/save_order_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<OrderCubit>().fetchOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<AppBloc, AppState>(
            listener: (context, state) {
              if (state is UserUnauthenticatedState) {
                UiHelper.showSnackBar(
                  context: context,
                  message: state.errorMessage,
                  isErrorSnackBar: true,
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              }
            },
          ),
          BlocListener<OrderCubit, OrderState>(
            listenWhen: (previous, current) =>
                previous.actionError != current.actionError ||
                previous.geolocationError != current.geolocationError,
            listener: (context, state) {
              final error = state.actionError.isNotEmpty
                  ? state.actionError
                  : state.geolocationError;
              UiHelper.showSnackBar(
                context: context,
                message: error,
                isErrorSnackBar: true,
              );
            },
          ),
          BlocListener<OrderCubit, OrderState>(
            listenWhen: (previous, current) =>
                previous.routeOptimizationStatus !=
                current.routeOptimizationStatus,
            listener: (context, state) {
              final optimizationStatus = state.routeOptimizationStatus;
              if (optimizationStatus == RouteOptimizationStatus.loading) {
                UiHelper.showConfirmDialog(
                  context,
                  const RouteOptimizationDialog(),
                );
              }
              if (optimizationStatus == RouteOptimizationStatus.success) {
                Navigator.pop(context);
              }
              if (optimizationStatus == RouteOptimizationStatus.failure) {
                UiHelper.showSnackBar(
                  context: context,
                  message: state.optimizationError,
                  isErrorSnackBar: true,
                );
                Navigator.pop(context);
              }
            },
          ),
        ],
        child: SafeArea(
          child: Stack(
            children: [
              const GoogleMapSection(),
              Positioned(
                top: 25,
                left: 15,
                child: ActionFloatingButton(
                  icon: Iconsax.menu_1_copy,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ProfilePage(),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 300,
                right: 15,
                child: ActionFloatingButton(
                  icon: Iconsax.add,
                  heroTag: 'AddOrder',
                  onPressed: () {
                    UiHelper.showModalSheet(
                      context,
                      const SaveOrderPage(),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 225,
                right: 15,
                child: ActionFloatingButton(
                  icon: Iconsax.gps,
                  heroTag: 'GetUserLocation',
                  onPressed: () => context.read<OrderCubit>().getUserLocation(),
                ),
              ),
              const OrdersDraggableSheet(),
            ],
          ),
        ),
      ),
    );
  }
}
