import 'package:coubot/ai/widgets/recommendation_dialog.dart';
import 'package:coubot/features/home/presentation/cubits/home_cubit.dart';
import 'package:coubot/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecommendationBanner extends StatelessWidget {
  const RecommendationBanner({super.key});

  Future<void> _showRecommendation(BuildContext context) async {
    final homeCubit = context.read<HomeCubit>();

    await showDialog<void>(
      context: context,
      builder: (_) => BlocProvider.value(
        value: homeCubit,
        child: const RecommendationDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(
            colors: [Color(0xffC72C41), Color(0xffE5485F)],
          ),
        ),
        child: Row(
          children: [
            const Icon(Icons.auto_awesome, color: Colors.white, size: 40),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).aiRecommendationTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    S.of(context).aiRecommendationSubtitle,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xffC72C41),
                    ),
                    onPressed: () => _showRecommendation(context),
                    child: Text(S.of(context).aiRecommendButton),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
