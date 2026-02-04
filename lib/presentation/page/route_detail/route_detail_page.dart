import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/util/ui/ui_helper.dart';
import 'package:smart_courier_assistant/core/widget/common_progress_indicator.dart';
import 'package:smart_courier_assistant/data/model/route_model.dart';
import 'package:smart_courier_assistant/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_bloc.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_state.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/error_orders_section.dart';
import 'package:smart_courier_assistant/presentation/page/login/login_page.dart';
import 'package:smart_courier_assistant/presentation/page/route_detail/widget/route_order_card.dart';

class RouteDetailPage extends StatefulWidget {
  final RouteModel route;

  const RouteDetailPage({
    super.key,
    required this.route,
  });

  @override
  State<RouteDetailPage> createState() => _RouteDetailPageState();
}

class _RouteDetailPageState extends State<RouteDetailPage> {
  @override
  void initState() {
    context.read<OrderCubit>().fetchOrdersByRouteId(widget.route.routeId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).routeDetail),
      ),
      body: BlocListener<AppBloc, AppState>(
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
        child: SafeArea(
          minimum: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '#${widget.route.routeId}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '🗓 ${widget.route.date.day}.${widget.route.date.month}.${widget.route.date.year}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '📦 10 orders | ⚠️ 2 at risk',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const Divider(),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<OrderCubit, OrderState>(
                  builder: (context, state) {
                    final status = state.status;
                    if (status == OrderStatus.failure) {
                      return ErrorOrdersSection(
                        errorMessage: state.errorMessage,
                      );
                    }
                    if (status == OrderStatus.success) {
                      final activeOrders = state.orders;
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return RouteOrderCard(
                            index: index + 1,
                            order: activeOrders[index],
                          );
                        },
                        itemCount: activeOrders.length,
                      );
                    }
                    return const Center(
                      child: CommonProgressIndicator(
                        scale: 1.08,
                        color: Colors.blue,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
