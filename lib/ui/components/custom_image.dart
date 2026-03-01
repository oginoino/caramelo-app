import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomImage extends StatefulWidget {
  const CustomImage({
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholderIcon,
    this.errorIcon,
    this.showErrorMessage = false,
    this.errorMessageStyle,
    this.backgroundColor,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 2),
    this.timeout = const Duration(seconds: 30),
    super.key,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final IconData? placeholderIcon;
  final IconData? errorIcon;
  final bool showErrorMessage;
  final TextStyle? errorMessageStyle;
  final Color? backgroundColor;
  final int maxRetries;
  final Duration retryDelay;
  final Duration timeout;

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  int _retryCount = 0;
  bool _isRetrying = false;

  double _computeIconSize({
    required double fraction,
    required double defaultSize,
    double minSize = 16,
    double maxSize = 128,
  }) {
    final w = widget.width;
    final h = widget.height;
    final candidates = <double>[];
    if (w != null && w.isFinite && w > 0) candidates.add(w);
    if (h != null && h.isFinite && h > 0) candidates.add(h);
    if (candidates.isEmpty) {
      return defaultSize;
    }
    final base = candidates.reduce((a, b) => a < b ? a : b);
    final s = base * fraction;
    if (s.isFinite && s > 0) {
      return s.clamp(minSize, maxSize);
    }
    return defaultSize;
  }

  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.isAbsolute && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }

  void _handleRetryTap() {
    if (_isRetrying) return;

    setState(() {
      _isRetrying = true;
      _retryCount++;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _isRetrying = false;
        });
      }
    });
  }

  Widget _buildErrorWidget(BuildContext context, Color backgroundColor) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _handleRetryTap,
        borderRadius: widget.borderRadius,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: widget.borderRadius,
          ),
          child: Center(
            child: Icon(
              widget.errorIcon ?? Icons.image_outlined,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.35),
              size: _computeIconSize(fraction: 0.36, defaultSize: 28),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor =
        widget.backgroundColor ??
        theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.1);
    final effectiveUrl = _retryCount > 0
        ? '${widget.imageUrl}${widget.imageUrl.contains('?') ? '&' : '?'}retry=$_retryCount'
        : widget.imageUrl;

    if (widget.imageUrl.isEmpty || !_isValidUrl(widget.imageUrl)) {
      return _buildErrorWidget(context, effectiveBackgroundColor);
    }

    return CachedNetworkImage(
      imageUrl: effectiveUrl,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      fadeInDuration: const Duration(milliseconds: 200),
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            image: DecorationImage(image: imageProvider, fit: widget.fit),
          ),
        );
      },
      placeholder: (context, url) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: effectiveBackgroundColor,
            borderRadius: widget.borderRadius,
          ),
          child: Center(
            child: Icon(
              widget.placeholderIcon ?? Icons.image_outlined,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.25),
              size: _computeIconSize(fraction: 0.32, defaultSize: 24),
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return _buildErrorWidget(context, effectiveBackgroundColor);
      },
    );
  }
}
