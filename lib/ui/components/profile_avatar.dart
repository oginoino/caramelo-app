import '../../util/import/packages.dart';
import '../../util/const/ui/ui_token.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key, this.onPressed, this.tooltip = 'Profile'});

  final VoidCallback? onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    final avatarBg = isLight
        ? UiToken.primaryLight200
        : UiToken.primaryLight900;
    final avatarFg = isLight
        ? UiToken.primaryLight600
        : UiToken.primaryLight500;

    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      icon: CircleAvatar(
        radius: UiToken.shadow16,
        backgroundColor: avatarBg,
        child: Icon(
          Icons.person_rounded,
          size: UiToken.textSize24,
          color: avatarFg,
        ),
      ),
    );
  }
}
