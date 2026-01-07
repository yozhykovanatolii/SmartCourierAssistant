import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class EditProfileUserAvatarSection extends StatelessWidget {
  const EditProfileUserAvatarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Stack(
        children: [
          _EditProfileAvatar(),
          Positioned(
            right: 0.5,
            bottom: 1,
            child: _EditAvatarButton(),
          ),
        ],
      ),
    );
  }
}

class _EditProfileAvatar extends StatelessWidget {
  const _EditProfileAvatar();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 120,
      width: 120,
      child: CircleAvatar(
        backgroundImage: AssetImage(
          'assets/images/test.jpg',
        ),
      ),
    );
  }
}

class _EditAvatarButton extends StatelessWidget {
  const _EditAvatarButton();

  @override
  Widget build(BuildContext context) {
    return IconButton.filled(
      onPressed: () {},
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.blue),
      ),
      icon: const Icon(
        Iconsax.edit_copy,
      ),
    );
  }
}
