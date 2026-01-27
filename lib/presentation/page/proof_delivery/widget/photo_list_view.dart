import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_courier_assistant/presentation/bloc/proof_delivery/proof_delivery_cubit.dart';
import 'package:smart_courier_assistant/presentation/page/proof_delivery/widget/dashed_border.dart';

class PhotoListView extends StatelessWidget {
  const PhotoListView({super.key});

  @override
  Widget build(BuildContext context) {
    final orderPhotos = context.select(
      (ProofDeliveryCubit cubit) => cubit.state.orderPhotos,
    );
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: orderPhotos.length + 1,
        itemBuilder: (context, index) {
          if (index < orderPhotos.length) {
            return _PhotoCardItem(
              photoUrl: orderPhotos[index],
            );
          }
          return const _OpenGalleryButton();
        },
        separatorBuilder: (_, __) => const SizedBox(width: 10),
      ),
    );
  }
}

class _PhotoCardItem extends StatelessWidget {
  final String photoUrl;

  const _PhotoCardItem({
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 120,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12),
            child: Image.network(
              fit: BoxFit.cover,
              photoUrl,
            ),
          ),
        ),
        Positioned(
          left: 75,
          child: IconButton(
            iconSize: 30,
            onPressed: () =>
                context.read<ProofDeliveryCubit>().deleteOrderPhoto(photoUrl),
            style: const ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(Colors.white),
            ),
            icon: const Icon(
              Iconsax.close_circle,
            ),
          ),
        ),
      ],
    );
  }
}

class _OpenGalleryButton extends StatelessWidget {
  const _OpenGalleryButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<ProofDeliveryCubit>().addOrderPhoto(),
      child: CustomPaint(
        painter: DashedBorder(),
        child: Container(
          width: 120,
          alignment: Alignment.center,
          child: const Icon(
            size: 30,
            Iconsax.add_circle,
          ),
        ),
      ),
    );
  }
}
