import '../../util/import/packages.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/provider.dart';
import '../../util/import/service.dart';

class LocationBottomSheet extends StatefulWidget {
  const LocationBottomSheet({super.key});

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context, listen: false);
    final onSurface = Theme.of(context).colorScheme.onSurface;
    final hintColor = onSurface.withValues(alpha: 0.6);

    final normalizedQuery = _query.trim().toLowerCase();
    final filtered = normalizedQuery.isEmpty
        ? provider.locations
        : provider.locations
              .where((loc) => loc.name.toLowerCase().contains(normalizedQuery))
              .toList();
    final canAdd =
        normalizedQuery.isNotEmpty &&
        !provider.locations.any(
          (loc) => loc.name.toLowerCase() == normalizedQuery,
        );

    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.75,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: UiToken.spacing16,
              vertical: UiToken.spacing12,
            ),
            child: Text(
              LocalizationService.strings.newLocationTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: UiToken.spacing16),
            child: TextField(
              autofocus: true,
              style: Theme.of(context).textTheme.bodyLarge,
              cursorColor: onSurface,
              decoration: InputDecoration(
                labelText: LocalizationService.strings.search,
                hintText: LocalizationService.strings.newLocationHint,
                labelStyle: TextStyle(color: hintColor),
                hintStyle: TextStyle(color: hintColor),
                prefixIcon: Icon(Icons.search_rounded, color: hintColor),
              ),
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                setState(() => _query = value);
              },
              onSubmitted: (value) async {
                final name = value.trim();
                if (name.isEmpty) return;
                await provider.addLocation(name);
                if (context.mounted) Navigator.of(context).pop();
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length + (canAdd ? 1 : 0),
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                if (canAdd && index == 0) {
                  final name = _query.trim();
                  return ListTile(
                    leading: const Icon(Icons.add_location_alt_rounded),
                    title: Text(LocalizationService.strings.addLocation),
                    subtitle: Text(name, style: TextStyle(color: hintColor)),
                    onTap: () async {
                      await provider.addLocation(name);
                      if (context.mounted) Navigator.of(context).pop();
                    },
                  );
                }

                final location = filtered[index - (canAdd ? 1 : 0)];
                return ListTile(
                  leading: const Icon(Icons.location_on_rounded),
                  title: Text(location.name),
                  onTap: () {
                    provider.setSelectedLocation(location.name);
                    Navigator.of(context).pop();
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
                onPressed: () => Navigator.of(context).pop(),
                child: Text(LocalizationService.strings.cancel),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
