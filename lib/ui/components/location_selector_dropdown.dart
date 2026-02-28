import '../../util/import/packages.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/provider.dart';
import '../../util/import/service.dart';

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
    final provider = Provider.of<LocationProvider>(context, listen: false);
    String query = '';

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(sheetContext).bottom,
          ),
          child: StatefulBuilder(
            builder: (sheetContext, setSheetState) {
              final normalizedQuery = query.trim().toLowerCase();
              final filtered = normalizedQuery.isEmpty
                  ? provider.locations
                  : provider.locations
                        .where(
                          (loc) =>
                              loc.name.toLowerCase().contains(normalizedQuery),
                        )
                        .toList();
              final canAdd =
                  normalizedQuery.isNotEmpty &&
                  !provider.locations.any(
                    (loc) => loc.name.toLowerCase() == normalizedQuery,
                  );

              return SizedBox(
                height: MediaQuery.sizeOf(sheetContext).height * 0.75,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: UiToken.spacing16,
                        vertical: UiToken.spacing12,
                      ),
                      child: Text(
                        LocalizationService.strings.newLocationTitle,
                        style: Theme.of(sheetContext).textTheme.titleMedium,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: UiToken.spacing16,
                      ),
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: LocalizationService.strings.search,
                          hintText: LocalizationService.strings.newLocationHint,
                          prefixIcon: const Icon(Icons.search_rounded),
                        ),
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          setSheetState(() {
                            query = value;
                          });
                        },
                        onSubmitted: (value) async {
                          final name = value.trim();
                          if (name.isEmpty) return;
                          await provider.addLocation(name);
                          if (sheetContext.mounted) {
                            Navigator.of(sheetContext).pop();
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.separated(
                        itemCount: filtered.length + (canAdd ? 1 : 0),
                        separatorBuilder: (context, index) =>
                            const Divider(height: 1),
                        itemBuilder: (context, index) {
                          if (canAdd && index == 0) {
                            final name = query.trim();
                            return ListTile(
                              leading: const Icon(
                                Icons.add_location_alt_rounded,
                              ),
                              title: Text(
                                LocalizationService.strings.addLocation,
                              ),
                              subtitle: Text(name),
                              onTap: () async {
                                await provider.addLocation(name);
                                if (sheetContext.mounted) {
                                  Navigator.of(sheetContext).pop();
                                }
                              },
                            );
                          }

                          final location = filtered[index - (canAdd ? 1 : 0)];
                          return ListTile(
                            leading: const Icon(Icons.location_on_rounded),
                            title: Text(location.name),
                            onTap: () {
                              provider.setSelectedLocation(location.name);
                              Navigator.of(sheetContext).pop();
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(UiToken.spacing16),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(sheetContext).pop(),
                          child: Text(LocalizationService.strings.cancel),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
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
