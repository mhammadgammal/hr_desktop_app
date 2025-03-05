import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hr/core/theme/app_colors.dart';
import 'package:hr/core/widgets/drawer/entity/navigation_drawer_entity_item.dart';

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    super.key,
    required this.item,
    required this.isSelected,
  });

  final NavigationDrawerEntityItem item;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: isSelected,
      selectedTileColor: AppColors.white,
      title: Text(
        item.title,
        style: TextStyle(
          color: isSelected ? AppColors.secondaryColor : AppColors.white,
        ),
      ),
      leading: SvgPicture.asset(
        item.iconPath,
        color: isSelected ? AppColors.secondaryColor : null,
      ),
      onTap: item.onTap,
    );
  }
}
