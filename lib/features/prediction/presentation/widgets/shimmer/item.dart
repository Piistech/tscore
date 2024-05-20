import '../../../../../core/shared/shared.dart';

class ShimmerPredictionItem extends StatelessWidget {
  const ShimmerPredictionItem({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.horizontalMargin12,
            vertical: context.verticalMargin12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.radius12),
            color: theme.backgroundSecondary,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: ShimmerLabel(width: 100.w, height: 11.h).animate(
                      onComplete: (controller) => controller.repeat(),
                    )..shimmer(
                        color: theme.shimmerColor,
                        duration: const Duration(seconds: 1),
                      ),
                  ),
                  ShimmerLabel(width: 72.w, height: 11.h).animate(
                    onComplete: (controller) => controller.repeat(),
                  )..shimmer(
                      color: theme.shimmerColor,
                      duration: const Duration(seconds: 1),
                    ),
                ],
              ),
              SizedBox(height: context.verticalMargin8),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(context.radius10),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: ShimmerIcon(radius: context.radius10).animate(
                          onComplete: (controller) => controller.repeat(),
                        )..shimmer(
                            color: theme.shimmerColor,
                            duration: const Duration(seconds: 1),
                          ),
                      ),
                      SizedBox(height: context.horizontalMargin12),
                      ShimmerLabel(width: 72.w, height: 11.h).animate(
                    onComplete: (controller) => controller.repeat(),
                  )..shimmer(
                      color: theme.shimmerColor,
                      duration: const Duration(seconds: 1),
                    ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: context.verticalMargin8),
              Align(
                alignment: Alignment.center,
                child: ShimmerLabel(width: 128.w, height: 11.h).animate(
                    onComplete: (controller) => controller.repeat(),
                  )..shimmer(
                      color: theme.shimmerColor,
                      duration: const Duration(seconds: 1),
                    ),
              ),
              SizedBox(height: context.verticalMargin8),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: context.horizontalMargin8, vertical: context.verticalMargin4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(context.radius5),
                    color: theme.backgroundTertiary,
                  ),
                  child: ShimmerLabel(width: 72.w, height: 11.h).animate(
                    onComplete: (controller) => controller.repeat(),
                  )..shimmer(
                      color: theme.shimmerColor,
                      duration: const Duration(seconds: 1),
                    ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
