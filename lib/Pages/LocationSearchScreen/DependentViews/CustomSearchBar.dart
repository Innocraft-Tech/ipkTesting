import 'package:flutter/material.dart';
import 'package:zappy/Helpers/Resources/Styles/Styles.dart';
import 'package:zappy/Pages/LocationSearchScreen/AppColors.dart';

class CustomSearchBar extends StatelessWidget {
  final String hint;
  final Color dotColor;
  final TextEditingController controller;
  final VoidCallback onFocus;
  final Function(String) onChanged;
  final Function(String) onLocationSelected;

  const CustomSearchBar({
    super.key,
    required this.hint,
    required this.dotColor,
    required this.controller,
    required this.onFocus,
    required this.onChanged,
    required this.onLocationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white,
            width: 1.0,
          )),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Focus(
              onFocusChange: (hasFocus) {
                if (hasFocus) {
                  onFocus();
                }
              },
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
