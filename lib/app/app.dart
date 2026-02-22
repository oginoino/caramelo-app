import '../util/import/di.dart';
import '../util/import/packages.dart';
import '../util/const/router/router_config.dart';
import '../util/const/locale/locale_config.dart';
import '../provider/theme/theme_provider.dart';
import '../provider/locale_provider/locale_provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme;
    Locale? locale;
    String appNameValue = 'App';
    String appTitleValue = 'App';
    try {
      theme = context.watch<ThemeProvider>().currentTheme;
    } catch (_) {
      theme = ThemeData.light();
    }
    try {
      locale = context.watch<LocaleProvider>().currentLocale;
    } catch (_) {
      locale = null;
    }
    try {
      appNameValue = appConstants.appName;
      appTitleValue = appConstants.appTitle;
    } catch (_) {
      appNameValue = 'App';
      appTitleValue = 'App';
    }

    return MaterialApp.router(
      onGenerateTitle: (BuildContext context) => appNameValue,
      title: appTitleValue,
      routerConfig: appRouter,
      builder: (context, child) => child ?? const Placeholder(),
      theme: theme,
      debugShowCheckedModeBanner: false,
      locale: locale,
      localizationsDelegates: LocaleConfig.localizationDelegates,
      supportedLocales: LocaleConfig.supportedLocales,
    );
  }
}
