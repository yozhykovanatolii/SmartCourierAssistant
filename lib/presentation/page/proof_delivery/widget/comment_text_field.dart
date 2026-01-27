import 'package:flutter/material.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: TextField(
        maxLines: null,
        minLines: 5,
        onChanged: (comment) {},
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF6F6F6),
          hintText: 'Enter comment...',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
