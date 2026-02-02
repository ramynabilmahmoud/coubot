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

    // منع via.placeholder.com نهائيًا + fallback ثابت
    if (u.isEmpty || u.contains('via.placeholder.com')) {
      return "https://picsum.photos/seed/$seed/900/600";
    }
    return u;
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      _resolved,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const Center(child: CircularProgressIndicator.adaptive());
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.black12,
          alignment: Alignment.center,
          child: const Icon(Icons.image_not_supported_outlined, size: 28),
        );
      },
    );
  }
}
