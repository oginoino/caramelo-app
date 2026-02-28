// import removed in favor of packages aggregator
import '../../util/import/packages.dart';
import '../../util/import/provider.dart';
import '../../util/import/service.dart';
import '../../util/import/ui.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomSliverAppBar(
          title: LocalizationService.strings.home,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer<MessageProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading) {
                    return const SizedBox(height: 80);
                  }
                  if (provider.items.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return MessageCarousel(messages: provider.items);
                },
              ),
              Search(),
            ],
          ),
        ),
      ],
    );
  }
}
