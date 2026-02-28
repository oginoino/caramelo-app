import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart';
import '../../util/import/provider.dart';

class ThemeToggle extends StatefulWidget {
  const ThemeToggle({super.key});

  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDarkMode = themeProvider.isDarkMode;
    final isLightTheme = Theme.of(context).brightness == Brightness.light;

    return GestureDetector(
      onTap: () {
        themeProvider.toggleTheme();
      },
      child: Container(
        width: 60,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
          color: isLightTheme
              ? UiToken.secondaryLight200
              : UiToken.secondaryDark700,
          border: Border.all(
            color: isLightTheme
                ? UiToken.secondaryLight400
                : UiToken.secondaryDark500,
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            if (isDarkMode)
              Positioned(
                left: 8,
                top: 8,
                child: Icon(
                  Icons.light_mode,
                  size: UiToken.textSize16,
                  color: isLightTheme
                      ? UiToken.secondaryLight600
                      : UiToken.secondaryLight400.withValues(
                          alpha: UiToken.opacity75,
                        ),
                ),
              ),
            if (!isDarkMode)
              Positioned(
                right: 8,
                top: 8,
                child: Icon(
                  Icons.dark_mode,
                  size: UiToken.textSize16,
                  color: isLightTheme
                      ? UiToken.secondaryLight600
                      : UiToken.secondaryDark500,
                ),
              ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: isDarkMode ? 28 : 4,
              top: 4,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(UiToken.borderRadiusFull),
                  color: isLightTheme
                      ? (isDarkMode
                            ? UiToken.primaryDark600
                            : UiToken.primaryLight600)
                      : (isDarkMode
                            ? UiToken.primaryDark600
                            : UiToken.primaryLight600),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Icon(
                  isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  size: UiToken.textSize16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
