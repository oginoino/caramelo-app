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

    return MaterialApp.router(
      onGenerateTitle: (BuildContext context) => appConstants.appName,
      title: appConstants.appTitle,
      routerDelegate: appRouter.routerDelegate,
      routeInformationParser: appRouter.routeInformationParser,
      routeInformationProvider: appRouter.routeInformationProvider,
      theme: theme,
      debugShowCheckedModeBanner: false,
      locale: locale,
      localizationsDelegates: LocaleConfig.localizationDelegates,
      supportedLocales: LocaleConfig.supportedLocales,
    );
  }
}
