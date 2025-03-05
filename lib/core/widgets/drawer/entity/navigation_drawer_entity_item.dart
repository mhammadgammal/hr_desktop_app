class NavigationDrawerEntityItem {
  late final String title;
  late final String iconPath;
  late final void Function() onTap;

  NavigationDrawerEntityItem({
    required this.title,
    required this.iconPath,
    required this.onTap,
  });
}
