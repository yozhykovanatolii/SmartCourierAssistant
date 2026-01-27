import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:smart_courier_assistant/presentation/page/proof_delivery/widget/dashed_border.dart';

class PhotoListView extends StatelessWidget {
  const PhotoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 11,
        itemBuilder: (context, index) {
          if (index < 10) {
            return const _PhotoCardItem(
              photoUrl: '',
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
            onPressed: () {},
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
      onTap: () {},
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
