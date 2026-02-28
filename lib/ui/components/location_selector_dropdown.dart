import '../../util/import/packages.dart';

class LocationSelectorDropdown extends StatefulWidget {
  const LocationSelectorDropdown({super.key, this.initialSelection});

  final String? initialSelection;

  @override
  State<LocationSelectorDropdown> createState() =>
      _LocationSelectorDropdownState();
}

class _LocationSelectorDropdownState extends State<LocationSelectorDropdown> {
  final List<String> _locations = ['Minha casa', 'Trabalho'];
  String? _selectedLocation;

  @override
  void initState() {
    super.initState();
    if (widget.initialSelection != null &&
        _locations.contains(widget.initialSelection)) {
      _selectedLocation = widget.initialSelection;
    } else {
      _selectedLocation = _locations.isNotEmpty ? _locations.first : null;
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
      if (!_locations.contains(result)) {
        setState(() {
          _locations.add(result);
          _selectedLocation = result;
        });
      } else {
        setState(() {
          _selectedLocation = result;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: _selectedLocation,
        items: [
          ..._locations.map(
            (loc) => DropdownMenuItem<String>(
              value: loc,
              child: Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 18),
                  const SizedBox(width: 8),
                  Text(loc),
                ],
              ),
            ),
          ),
          const DropdownMenuItem<String>(
            value: '__add__',
            child: Row(
              children: [
                Icon(Icons.add_location_alt_outlined, size: 18),
                SizedBox(width: 8),
                Text('Adicionar localização...'),
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
                    const Icon(Icons.location_on_outlined, size: 18),
                    const SizedBox(width: 8),
                    Text(loc),
                  ],
                ),
              )
              .toList();
        },
      ),
    );
  }
}
