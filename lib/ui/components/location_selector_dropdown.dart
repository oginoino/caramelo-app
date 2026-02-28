import '../../util/import/packages.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/di.dart' as di;
import '../../util/import/domain.dart';

class LocationSelectorDropdown extends StatefulWidget {
  const LocationSelectorDropdown({super.key, this.initialSelection});

  final String? initialSelection;

  @override
  State<LocationSelectorDropdown> createState() =>
      _LocationSelectorDropdownState();
}

class _LocationSelectorDropdownState extends State<LocationSelectorDropdown> {
  List<Location> _locations = const [];
  String? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    try {
      final repo = di.locationRepository;
      final items = await repo.getLocations();
      setState(() {
        _locations = items;
        if (widget.initialSelection != null &&
            items.any((e) => e.name == widget.initialSelection)) {
          _selectedLocation = widget.initialSelection;
        } else {
          _selectedLocation = items.isNotEmpty ? items.first.name : null;
        }
      });
    } catch (e) {
      setState(() {
        _locations = const [];
        _selectedLocation = null;
      });
    }
  }

  Future<void> _addNewLocation() async {
    final controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nova localização'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Ex.: Casa da mãe'),
            textInputAction: TextInputAction.done,
            onSubmitted: (_) {
              Navigator.of(context).pop(controller.text.trim());
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).pop(controller.text.trim()),
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );

    if (result != null && result.isNotEmpty) {
      final exists = _locations.any((e) => e.name == result);
      setState(() {
        if (!exists) {
          _locations = List<Location>.from(_locations)
            ..add(
              Location(
                id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
                name: result,
              ),
            );
        }
        _selectedLocation = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            value: _selectedLocation,
            isExpanded: true,
            borderRadius: BorderRadius.circular(UiToken.borderRadius12),
            dropdownColor: Theme.of(context).colorScheme.surface,
            style: TextStyle(color: textColor),
            iconEnabledColor: textColor,
            iconDisabledColor: disabledIconColor,
            items: [
              ..._locations.map(
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
                        'Adicionar localização...',
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
                await _addNewLocation();
                return;
              }
              setState(() {
                _selectedLocation = value;
              });
            },
            selectedItemBuilder: (context) {
              return _locations
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
  }
}
