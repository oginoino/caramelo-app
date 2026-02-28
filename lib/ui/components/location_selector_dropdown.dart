import '../../util/import/packages.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/provider.dart';
import '../../util/import/service.dart';
import 'location_bottom_sheet.dart';

class LocationSelectorDropdown extends StatefulWidget {
  const LocationSelectorDropdown({super.key, this.initialSelection});

  final String? initialSelection;

  @override
  State<LocationSelectorDropdown> createState() =>
      _LocationSelectorDropdownState();
}

class _LocationSelectorDropdownState extends State<LocationSelectorDropdown> {
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

  @override
  Widget build(BuildContext context) {
    return Consumer<LocationProvider>(
      builder: (context, provider, child) {
        final maxWidth = MediaQuery.sizeOf(context).width * 2 / 3;
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final onSurface = Theme.of(context).colorScheme.onSurface;
        final textColor = isDark ? UiToken.secondaryLight200 : onSurface;
        final disabledIconColor = isDark
            ? UiToken.secondaryLight400
            : onSurface.withValues(alpha: 0.6);

        return Align(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: provider.selectedLocation,
                isExpanded: true,
                borderRadius: BorderRadius.circular(UiToken.borderRadius12),
                dropdownColor: Theme.of(context).colorScheme.surface,
                style: TextStyle(color: textColor),
                iconEnabledColor: textColor,
                iconDisabledColor: disabledIconColor,
                items: [
                  ...provider.locations.map(
                    (loc) => DropdownMenuItem<String>(
                      value: loc.name,
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
                  DropdownMenuItem<String>(
                    value: '__add__',
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
                ],
                onChanged: (value) async {
                  if (value == '__add__') {
                    await _openLocationBottomSheet();
                    return;
                  }
                  provider.setSelectedLocation(value);
                },
                selectedItemBuilder: (context) {
                  return provider.locations
                      .map(
                        (loc) => Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              size: 18,
                              color: textColor,
                            ),
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
                      )
                      .toList();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
