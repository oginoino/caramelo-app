import '../../util/import/packages.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/provider.dart';
import '../../util/import/service.dart';
import 'theme_toggle.dart';

class ProfileBottomSheet extends StatelessWidget {
  const ProfileBottomSheet({super.key});

  Locale _normalizeLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return const Locale('en', 'US');
      case 'es':
        return const Locale('es', 'MX');
      case 'pt':
        return const Locale('pt', 'BR');
      default:
        return const Locale('pt', 'BR');
    }
  }

  String _localeLabel(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'pt':
        return 'Português (Brasil)';
      default:
        return 'Português (Brasil)';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final textColor = isDark ? UiToken.secondaryLight200 : onSurface;
    final localeProvider = context.watch<LocaleProvider>();
    final selectedLocale = _normalizeLocale(localeProvider.currentLocale);

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.55,
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
            trailing: const ThemeToggle(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: UiToken.spacing16,
              vertical: UiToken.spacing12,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                LocalizationService.strings.language,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: textColor),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.language_rounded, color: textColor),
            title: Text(
              LocalizationService.strings.language,
              style: TextStyle(color: textColor),
            ),
            trailing: SizedBox(
              width: 150,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Locale>(
                  value: selectedLocale,
                  isExpanded: true,
                  borderRadius: BorderRadius.circular(UiToken.borderRadius12),
                  dropdownColor: Theme.of(context).colorScheme.surface,
                  style: TextStyle(color: textColor),
                  iconEnabledColor: textColor,
                  items:
                      const [
                        Locale('pt', 'BR'),
                        Locale('en', 'US'),
                        Locale('es', 'MX'),
                      ].map((locale) {
                        return DropdownMenuItem<Locale>(
                          value: locale,
                          child: Text(_localeLabel(locale)),
                        );
                      }).toList(),
                  onChanged: (locale) {
                    if (locale == null) return;
                    localeProvider.setLocale(locale);
                  },
                ),
              ),
            ),
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
