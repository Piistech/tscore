import 'package:tscore/core/shared/shared.dart';

class ShimmerPrediction extends StatelessWidget {
  const ShimmerPrediction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.horizontalMargin30,
                vertical: context.verticalMargin10,
              ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: theme.backgroundSecondary),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ShimmerLabel(width: 100.w, height: 11.h).animate(
                      onComplete: (controller) => controller.repeat(),
                    )..shimmer(
                        color: theme.shimmerColor,
                        duration: const Duration(seconds: 1),
                      ),
                  ),
                  SizedBox(height: context.verticalMargin25),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerLabel(width: 88.w, height: 11.h).animate(
                        onComplete: (controller) => controller.repeat(),
                      )..shimmer(
                          color: theme.shimmerColor,
                          duration: const Duration(seconds: 1),
                        ),
                      ShimmerLabel(width: 100.w, height: 11.h).animate(
                        onComplete: (controller) => controller.repeat(),
                      )..shimmer(
                          color: theme.shimmerColor,
                          duration: const Duration(seconds: 1),
                        ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: context.verticalMargin15),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.horizontalMargin30,
                vertical: context.verticalMargin10,
              ),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: theme.backgroundSecondary),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ShimmerLabel(width: 100.w, height: 11.h).animate(
                      onComplete: (controller) => controller.repeat(),
                    )..shimmer(
                        color: theme.shimmerColor,
                        duration: const Duration(seconds: 1),
                      ),
                  ),
                  SizedBox(height: context.verticalMargin25),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerLabel(width: 88.w, height: 11.h).animate(
                        onComplete: (controller) => controller.repeat(),
                      )..shimmer(
                          color: theme.shimmerColor,
                          duration: const Duration(seconds: 1),
                        ),
                      ShimmerLabel(width: 100.w, height: 11.h).animate(
                        onComplete: (controller) => controller.repeat(),
                      )..shimmer(
                          color: theme.shimmerColor,
                          duration: const Duration(seconds: 1),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
