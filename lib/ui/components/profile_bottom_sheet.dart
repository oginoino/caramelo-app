import '../../util/import/packages.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/provider.dart';
import '../../util/import/service.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final textColor = isDark ? UiToken.secondaryLight200 : onSurface;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.35,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: UiToken.spacing16,
              vertical: UiToken.spacing12,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                LocalizationService.strings.toggleTheme,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: textColor),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.brightness_6_rounded, color: textColor),
            title: Text(
              LocalizationService.strings.toggleTheme,
              style: TextStyle(color: textColor),
            ),
            trailing: Switch(
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.setDarkMode(value);
              },
            ),
            onTap: () {
              themeProvider.setDarkMode(!themeProvider.isDarkMode);
            },
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.all(UiToken.spacing16),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  LocalizationService.strings.cancel,
                  style: TextStyle(color: textColor.withValues(alpha: 0.9)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
