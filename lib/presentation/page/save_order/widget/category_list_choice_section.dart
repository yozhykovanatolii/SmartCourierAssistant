import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_courier_assistant/presentation/bloc/save_order/save_order_cubit.dart';

class CategoryListChoiceSection extends StatelessWidget {
  static const categories = [
    '📦 Parcel',
    '🍔 Food',
    '📄 Docs',
  ];

  const CategoryListChoiceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 2.16,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: List.generate(
          categories.length,
          (index) => _CategoryCard(
            category: categories[index],
          ),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String category;

  const _CategoryCard({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final isCategorySelected = context.select(
      (SaveOrderCubit cubit) => cubit.state.category == category,
    );
    return GestureDetector(
      onTap: () => context.read<SaveOrderCubit>().chooseOrderCategory(category),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        decoration: BoxDecoration(
          color: isCategorySelected ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            category,
            style: TextStyle(
              fontSize: MediaQuery.textScalerOf(context).scale(17),
              color: isCategorySelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
