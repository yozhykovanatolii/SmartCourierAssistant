import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/core/util/ui/ui_helper.dart';
import 'package:smart_courier_assistant/core/widget/common_progress_indicator.dart';
import 'package:smart_courier_assistant/core/localization/generated/l10n.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_bloc.dart';
import 'package:smart_courier_assistant/presentation/bloc/app/app_state.dart';
import 'package:smart_courier_assistant/presentation/bloc/route/route_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/route/route_state.dart';
import 'package:smart_courier_assistant/presentation/page/login/login_page.dart';
import 'package:smart_courier_assistant/presentation/page/routes_history/widget/error_routes_section.dart';
import 'package:smart_courier_assistant/presentation/page/routes_history/widget/route_card.dart';

class RoutesHistoryPage extends StatefulWidget {
  const RoutesHistoryPage({super.key});

  @override
  State<RoutesHistoryPage> createState() => _RoutesHistoryPageState();
}

class _RoutesHistoryPageState extends State<RoutesHistoryPage> {
  @override
  void initState() {
    context.read<RouteCubit>().fetchAllCourierRoutes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).myRoutes),
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
        child: BlocBuilder<RouteCubit, RouteState>(
          builder: (context, state) {
            if (state is RouteFailureState) {
              return ErrorRoutesSection(
                errorMessage: state.errorMessage,
              );
            }
            if (state is RouteSuccessState) {
              final routes = state.routes;
              return ListView.builder(
                itemCount: routes.length,
                itemBuilder: (context, index) {
                  return RouteCard(
                    route: routes[index],
                  );
                },
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
    );
  }
}
