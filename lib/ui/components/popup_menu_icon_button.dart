import '../../util/import/packages.dart';
import '../../util/import/provider.dart';

class PopupMenuIconButton extends StatelessWidget {
  const PopupMenuIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'toggle_theme',
          child: TextButton.icon(
            label: Text('Toggle Theme'),
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
              Navigator.pop(context);
            },
            autofocus: false,
          ),
        ),
      ],
    );
  }
}
