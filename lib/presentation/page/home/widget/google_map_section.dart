import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_courier_assistant/data/model/order_model.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_cubit.dart';
import 'package:smart_courier_assistant/presentation/bloc/order/order_state.dart';

class GoogleMapSection extends StatefulWidget {
  const GoogleMapSection({super.key});

  @override
  State<GoogleMapSection> createState() => _GoogleMapSectionState();
}

class _GoogleMapSectionState extends State<GoogleMapSection> {
  GoogleMapController? _controller;

  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderCubit, OrderState>(
      listenWhen: (prev, curr) =>
          prev.orders != curr.orders ||
          prev.routePoints != curr.routePoints ||
          prev.latitude != curr.latitude ||
          prev.longitude != curr.longitude,
      listener: (context, state) {
        _updateMap(state);
      },
      child: GoogleMap(
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        markers: _markers,
        polylines: _polylines,
        onMapCreated: (controller) => _controller ??= controller,
        initialCameraPosition: const CameraPosition(
          target: LatLng(50.4501, 30.5234),
          zoom: 16,
        ),
      ),
    );
  }

  void _updateMap(OrderState state) {
    if (_controller == null) return;

    setState(() {
      _markers = _buildOrderMarkers(state.orders);
      _polylines = _buildRoutePolyline(state.routePoints);
    });

    if (state.routePoints.isNotEmpty) {
      _moveCameraToBounds(state.routePoints);
    } else if (state.latitude != 0 && state.longitude != 0) {
      _moveCameraToUser(state.latitude, state.longitude);
    }
  }

  Set<Marker> _buildOrderMarkers(List<OrderModel> orders) {
    return orders.map((order) {
      return Marker(
        markerId: MarkerId(order.id),
        position: LatLng(order.latitude, order.longitude),
        infoWindow: InfoWindow(
          title: order.clientFullName,
          snippet: order.address,
        ),
      );
    }).toSet();
  }

  Set<Polyline> _buildRoutePolyline(List<LatLng> points) {
    return {
      Polyline(
        polylineId: const PolylineId('route'),
        points: points,
        width: 5,
        color: Colors.blue,
      ),
    };
  }

  void _moveCameraToBounds(List<LatLng> points) {
    if (_controller == null || points.isEmpty) return;

    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;

    for (final p in points) {
      minLat = min(minLat, p.latitude);
      maxLat = max(maxLat, p.latitude);
      minLng = min(minLng, p.longitude);
      maxLng = max(maxLng, p.longitude);
    }

    _controller!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        50,
      ),
    );
  }

  void _moveCameraToUser(double lat, double lng) {
    if (_controller == null) return;

    _controller!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 16,
        ),
      ),
    );
  }
}
