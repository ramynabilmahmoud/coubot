import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductImageWidget extends StatelessWidget {
  final String? url;
  final String seed;
  final BoxFit fit;

  const ProductImageWidget({
    super.key,
    required this.url,
    required this.seed,
    this.fit = BoxFit.cover,
  });

  String get _resolved {
    final u = (url ?? '').trim();
    if (u.isEmpty || u.contains('via.placeholder.com')) {
      return 'https://picsum.photos/seed/$seed/900/600';
    }
    return u;
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: _resolved,
      fit: fit,
      placeholder: (_, __) => const Center(child: CircularProgressIndicator.adaptive()),
      errorWidget: (_, __, ___) => Container(
        color: Colors.black12,
        alignment: Alignment.center,
        child: const Icon(Icons.image_not_supported_outlined, size: 28),
      ),
    );
  }
}
