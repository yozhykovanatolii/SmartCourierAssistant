import 'package:flutter/material.dart';

class CategoryListChoiceSection extends StatelessWidget {
  static const categories = [
    '📦 Parcel',
    '🍔 Food',
    '📄 Documents',
  ];

  const CategoryListChoiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        categories.length,
        (index) => _CategoryCard(text: categories[index]),
      ).toList(),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String text;

  const _CategoryCard({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: MediaQuery.textScalerOf(context).scale(17),
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
