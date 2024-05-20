import '../../../../../core/shared/shared.dart';

class ShimmerItemVertical extends StatelessWidget {
  const ShimmerItemVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(context.radius12),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: ShimmerLabel(width: 36.w, height: 14.h).animate(
                onComplete: (controller) => controller.repeat(),
              )..shimmer(
                  color: theme.shimmerColor,
                  duration: const Duration(seconds: 1),
                ),
            ),
            SizedBox(height: context.horizontalMargin12),
            ShimmerLabel(width: 100.w, height: 13.h).animate(
              onComplete: (controller) => controller.repeat(),
            )..shimmer(
                color: theme.shimmerColor,
                duration: const Duration(seconds: 1),
              ),
          ],
        );
      },
    );
  }
}
