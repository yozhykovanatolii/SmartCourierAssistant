import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class InformationDialogBox extends StatelessWidget {
  final String title;
  final String description;
  final bool isDeleting;
  final Function()? onClickActionButton;

  const InformationDialogBox({
    super.key,
    required this.title,
    required this.description,
    required this.onClickActionButton,
    this.isDeleting = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isDeleting ? Iconsax.danger : Iconsax.tick_circle,
              size: 65,
              color: isDeleting ? Colors.red : Colors.green,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: _DialogActionButton(
                    text: isDeleting ? 'No, Keep It.' : 'No, Cancel It.',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Expanded(
                  child: _DialogActionButton(
                    text: isDeleting ? 'Yes, Delete It!' : 'Yes, Confirm It!',
                    textColor: Colors.white,
                    color: isDeleting ? Colors.red : Colors.blue,
                    onPressed: onClickActionButton,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogActionButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final Function()? onPressed;

  const _DialogActionButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.grey,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 5,
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      ),
      child: Text(
        text,
        softWrap: false,
        overflow: TextOverflow.fade,
        style: TextStyle(
          color: textColor,
          fontSize: 15,
        ),
      ),
    );
  }
}
