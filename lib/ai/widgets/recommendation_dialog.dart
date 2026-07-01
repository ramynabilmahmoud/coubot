import 'package:coubot/ai/models/recommendation_model.dart';
import 'package:coubot/ai/services/recommendation_service.dart';
import 'package:coubot/config/themes/app_colors.dart';
import 'package:coubot/features/home/presentation/cubits/home_cubit.dart';
import 'package:coubot/features/home/presentation/cubits/home_state.dart';
import 'package:coubot/features/home/presentation/pages/product_details_screen.dart';
import 'package:coubot/features/home/presentation/widgets/product_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendationDialog extends StatefulWidget {
  const RecommendationDialog({super.key});

  @override
  State<RecommendationDialog> createState() => _RecommendationDialogState();
}

class _RecommendationDialogState extends State<RecommendationDialog> {
  final RecommendationService _service = RecommendationService();
  final List<String> _exclude = [];

  RecommendationModel? _recommendation;
  String? _error;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecommendation();
  }

  Future<void> _loadRecommendation() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final recommendation = await _service.getRecommendation(
        exclude: _exclude,
      );
      if (!mounted) return;

      setState(() {
        _recommendation = recommendation;
        if (!_exclude.contains(recommendation.id)) {
          _exclude.add(recommendation.id);
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _openProductDetails() {
    final recommendation = _recommendation;
    if (recommendation == null) return;

    final cubit = context.read<HomeCubit>();
    final product = recommendation.toProductEntity();
    final state = cubit.state;
    final isFavorite =
        state is HomeLoaded && state.favorites.contains(product.id);
    final navigator = Navigator.of(context);

    navigator.pop();
    navigator.push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: cubit,
          child: ProductsDetailsScreen(
            product: product,
            isFavorite: isFavorite,
            onToggleFavorite: () => cubit.toggleFavorite(product),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 430,
          maxHeight: size.height * 0.86,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: _isLoading
              ? const _LoadingRecommendation()
              : _error != null
              ? _RecommendationError(
                  message: _error!,
                  onRetry: _loadRecommendation,
                )
              : _RecommendationContent(
                  recommendation: _recommendation!,
                  onOrderNow: _openProductDetails,
                  onTryAnother: _loadRecommendation,
                ),
        ),
      ),
    );
  }
}

class _LoadingRecommendation extends StatelessWidget {
  const _LoadingRecommendation();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 280,
      child: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}

class _RecommendationError extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _RecommendationError({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(22),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.auto_awesome_motion_outlined,
              color: AppColors.primary,
              size: 42,
            ),
            const SizedBox(height: 14),
            const Text(
              'AI recommendation is unavailable',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              maxLines: 7,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.65),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: onRetry,
                    child: const Text('Try Again'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RecommendationContent extends StatelessWidget {
  final RecommendationModel recommendation;
  final VoidCallback onOrderNow;
  final VoidCallback onTryAnother;

  const _RecommendationContent({
    required this.recommendation,
    required this.onOrderNow,
    required this.onTryAnother,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 11,
                child: ProductImageWidget(
                  url: recommendation.imageUrl,
                  seed: recommendation.id,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Material(
                  color: Colors.black.withValues(alpha: 0.45),
                  shape: const CircleBorder(),
                  child: IconButton(
                    tooltip: 'Close',
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 16,
                            color: AppColors.primary,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'AI pick',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.schedule,
                      size: 18,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.55),
                    ),
                    const SizedBox(width: 4),
                    Text('${recommendation.estimatedTime} min'),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  recommendation.name,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  recommendation.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.64),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'EGP ${recommendation.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    recommendation.reason,
                    style: const TextStyle(
                      height: 1.35,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onTryAnother,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Try Another'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: onOrderNow,
                        icon: const Icon(Icons.shopping_bag_outlined),
                        label: const Text('Order Now'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
