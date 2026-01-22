import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_courier_assistant/core/util/ui_helper.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_cubit.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/action_floating_button.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/google_map_section.dart';
import 'package:smart_courier_assistant/presentation/page/home/widget/orders_draggable_sheet.dart';
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
      body: SafeArea(
        child: Stack(
          children: [
            const GoogleMapSection(),
            Positioned(
              top: 25,
              left: 15,
              child: ActionFloatingButton(
                icon: Iconsax.menu_1_copy,
                foregroundColor: Colors.black,
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
                foregroundColor: Colors.blue,
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
                foregroundColor: Colors.blue,
                heroTag: 'GetUserLocation',
                onPressed: () {},
              ),
            ),
            const OrdersDraggableSheet(),
          ],
        ),
      ),
    );
  }
}
