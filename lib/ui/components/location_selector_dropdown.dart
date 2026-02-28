import '../../util/import/packages.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/packages.dart' as math show min;
import '../../util/import/provider.dart';
import '../../util/import/service.dart';
import '../../util/import/ui.dart';

class LocationSelectorDropdown extends StatefulWidget {
  const LocationSelectorDropdown({super.key, this.initialSelection});

  final String? initialSelection;

  @override
  State<LocationSelectorDropdown> createState() =>
      _LocationSelectorDropdownState();
}

class _LocationSelectorDropdownState extends State<LocationSelectorDropdown> {
  final GlobalKey _anchorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<LocationProvider>(context, listen: false);
      if (widget.initialSelection != null &&
          provider.locations.any((e) => e.name == widget.initialSelection)) {
        provider.setSelectedLocation(widget.initialSelection);
      }
    });
  }

  Future<void> _openLocationBottomSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(sheetContext).bottom,
          ),
          child: const LocationBottomSheet(),
        );
      },
    );
  }

  Future<void> _openLocationMenu(LocationProvider provider) async {
    final renderBox =
        _anchorKey.currentContext?.findRenderObject() as RenderBox?;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    if (renderBox == null) return;

    final screenWidth = MediaQuery.sizeOf(context).width;
    final menuMaxWidth = math.min(screenWidth * 0.9, 420.0);

    final position = RelativeRect.fromRect(
      renderBox.localToGlobal(Offset.zero, ancestor: overlay) & renderBox.size,
      Offset.zero & overlay.size,
    );

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final textColor = isDark ? UiToken.secondaryLight200 : onSurface;

    final selected = await showMenu<String>(
      context: context,
      position: position,
      items: [
        ...provider.locations.map(
          (loc) => PopupMenuItem<String>(
            value: loc.name,
            child: AppTooltip(
              message: 'Selecionar ${loc.name}',
              child: SizedBox(
                width: menuMaxWidth,
                child: Row(
                  children: [
                    Icon(Icons.location_on_rounded, size: 18, color: textColor),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        loc.name,
                        style: TextStyle(color: textColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        PopupMenuItem<String>(
          value: '__add__',
          child: AppTooltip(
            message: 'Adicionar nova localização',
            child: SizedBox(
              width: menuMaxWidth,
              child: Row(
                children: [
                  Icon(
                    Icons.add_location_alt_rounded,
                    size: 18,
                    color: textColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      LocalizationService.strings.addLocation,
                      style: TextStyle(color: textColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );

    if (!mounted) return;
    if (selected == null) return;
    if (selected == '__add__') {
      await _openLocationBottomSheet();
      return;
    }
    provider.setSelectedLocation(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, provider, child) {
        final screenWidth = MediaQuery.sizeOf(context).width;
        final maxWidth = math.min(
          screenWidth * (2 / 3),
          360.0,
        ); // largura máxima absoluta
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final onSurface = Theme.of(context).colorScheme.onSurface;
        final textColor = isDark ? UiToken.secondaryLight200 : onSurface;
        final borderColor = isDark
            ? UiToken.secondaryDark600
            : UiToken.secondaryLight200;
        final backgroundColor =
            Theme.of(context).cardTheme.color ??
            Theme.of(context).colorScheme.surface;

        return LayoutBuilder(
          builder: (context, constraints) {
            final width = math.min(maxWidth, constraints.maxWidth);
            return Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: width,
                child: Material(
                  color: Colors.transparent,
                  child: AppTooltip(
                    message:
                        provider.selectedLocation ?? 'Selecionar localização',
                    child: InkWell(
                      key: _anchorKey,
                      borderRadius: BorderRadius.circular(
                        UiToken.borderRadiusFull,
                      ),
                      onTap: () => _openLocationMenu(provider),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        padding: EdgeInsets.symmetric(
                          horizontal: UiToken.spacing16,
                          vertical: UiToken.spacing8,
                        ),
                        decoration: BoxDecoration(
                          color: backgroundColor,
                          borderRadius: BorderRadius.circular(
                            UiToken.borderRadiusFull,
                          ),
                          border: Border.all(color: borderColor),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              size: 18,
                              color: textColor,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                provider.selectedLocation ?? '',
                                style: TextStyle(color: textColor),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.expand_more_rounded,
                              size: 18,
                              color: textColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
