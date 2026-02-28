import '../../util/import/packages.dart';
import '../../util/import/domain.dart';
import '../../util/const/ui/ui_token.dart';

class MessageCarousel extends StatefulWidget {
  const MessageCarousel({super.key, required this.messages});

  final List<Message> messages;

  @override
  State<MessageCarousel> createState() => _MessageCarouselState();
}

class _MessageCarouselState extends State<MessageCarousel> {
  late final PageController _controller;
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.9);
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    if (widget.messages.length <= 1) return;
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      _index = (_index + 1) % widget.messages.length;
      _controller.animateToPage(
        _index,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void didUpdateWidget(covariant MessageCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.messages.length != widget.messages.length) {
      _index = 0;
      _startAutoPlay();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.messages.isEmpty) {
      return const SizedBox.shrink();
    }

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 88,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.messages.length,
        padEnds: true,
        pageSnapping: true,
        itemBuilder: (context, index) {
          final message = widget.messages[index];

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: UiToken.spacing12),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(UiToken.borderRadius16),
                gradient: LinearGradient(
                  colors: isDark
                      ? [
                          UiToken.primaryLight200.withValues(alpha: 0.16),
                          UiToken.primaryLight100.withValues(alpha: 0.12),
                        ]
                      : [
                          UiToken.primaryLight500.withValues(alpha: 0.16),
                          UiToken.primaryLight400.withValues(alpha: 0.12),
                        ],
                ),
                border: Border.all(
                  color: isDark
                      ? UiToken.primaryLight300.withValues(alpha: 0.4)
                      : UiToken.primaryLight600.withValues(alpha: 0.4),
                ),
              ),
              child: Row(
                children: [
                  if (message.icon != null)
                    Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.only(left: UiToken.spacing12),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDark
                            ? UiToken.primaryLight200.withValues(alpha: 0.12)
                            : UiToken.primaryLight600.withValues(alpha: 0.18),
                      ),
                      child: Icon(
                        message.icon,
                        size: 22,
                        color: isDark
                            ? UiToken.primaryLight200
                            : UiToken.primaryLight800,
                      ),
                    ),
                  SizedBox(width: UiToken.spacing12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: UiToken.textSize14,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? UiToken.primaryLight200
                                : UiToken.primaryLight800,
                          ),
                        ),
                        if (message.description != null)
                          Text(
                            message.description!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: UiToken.textSize12,
                              fontWeight: FontWeight.w400,
                              color: isDark
                                  ? UiToken.secondaryLight300
                                  : UiToken.secondaryLight700,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
