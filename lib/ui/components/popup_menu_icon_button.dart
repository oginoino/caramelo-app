import '../../util/import/packages.dart';

class PopupMenuIconButton extends StatelessWidget {
  const PopupMenuIconButton({
    super.key,
    required this.icon,
    required this.items,
  });

  final Widget icon;
  final List<PopupMenuItem<String>> items;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: icon,
      padding: EdgeInsets.zero,
      itemBuilder: (context) => [...items],
    );
  }
}
