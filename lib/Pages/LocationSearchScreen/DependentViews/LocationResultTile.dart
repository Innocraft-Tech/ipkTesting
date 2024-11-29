import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zappy/Helpers/AppConstants/AppConstants.dart';
import 'package:zappy/Helpers/ResponsiveUI.dart';
import 'package:zappy/Pages/LocationSearchScreen/AppColors.dart';

class LocationResultTile extends StatelessWidget {
  final String name;
  final String address;
  final VoidCallback onTap;
  final int index;

  const LocationResultTile({
    super.key,
    required this.name,
    required this.address,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: [
            SvgPicture.asset(
              AppConstants.locationIcon,
              width: ResponsiveUI.w(24, context),
              height: ResponsiveUI.h(24, context),
              color: index == 0 ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              AppConstants.locationIndicator,
              width: ResponsiveUI.w(24, context),
              height: ResponsiveUI.h(24, context),
              color: index == 0 ? AppColors.primary : AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
