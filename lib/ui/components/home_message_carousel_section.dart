import '../../util/import/packages.dart';
import '../../util/import/provider.dart';
import '../../util/const/ui/ui_token.dart';
import '../../util/import/ui.dart';

class HomeMessageCarouselSection extends StatelessWidget {
  const HomeMessageCarouselSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: UiToken.spacing12),
            child: const SizedBox(height: 88),
          );
        }
        if (provider.items.isEmpty) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: EdgeInsets.symmetric(vertical: UiToken.spacing12),
          child: MessageCarousel(messages: provider.items),
        );
      },
    );
  }
}
