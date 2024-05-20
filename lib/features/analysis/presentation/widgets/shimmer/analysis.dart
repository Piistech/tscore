import '../../../../../core/shared/shared.dart';

class ShimmerAnalysis extends StatelessWidget {
  const ShimmerAnalysis({super.key});

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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShimmerLabel(width: 148.w, height: 11.h).animate(
                  onComplete: (controller) => controller.repeat(),
                )..shimmer(
                    color: theme.shimmerColor,
                    duration: const Duration(seconds: 1),
                  ),
                SizedBox(width: context.horizontalMargin10),
                ShimmerLabel(width: 88.w, height: 11.h).animate(
                  onComplete: (controller) => controller.repeat(),
                )..shimmer(
                    color: theme.shimmerColor,
                    duration: const Duration(seconds: 1),
                  ),
              ],
            ),
            SizedBox(height: context.verticalMargin16),
            Container(
              decoration: BoxDecoration(
                color: theme.backgroundSecondary,
                borderRadius: BorderRadius.circular(context.radius10),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: context.horizontalMargin19,
                vertical: context.verticalMargin14,
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: ShimmerLabel(width: 100.w, height: 11.h).animate(
                          onComplete: (controller) => controller.repeat(),
                        )..shimmer(
                            color: theme.shimmerColor,
                            duration: const Duration(seconds: 1),
                          ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(context.radius12),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: ShimmerLabel(width: 48.w, height: 14.h).animate(
                                onComplete: (controller) => controller.repeat(),
                              )..shimmer(
                                  color: theme.shimmerColor,
                                  duration: const Duration(seconds: 1),
                                ),
                            ),
                            SizedBox(width: context.horizontalMargin4),
                            ShimmerLabel(width: 24.w, height: 13.h).animate(
                              onComplete: (controller) => controller.repeat(),
                            )..shimmer(
                                color: theme.shimmerColor,
                                duration: const Duration(seconds: 1),
                              ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(context.radius12),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: ShimmerLabel(width: 48.w, height: 14.h).animate(
                              onComplete: (controller) => controller.repeat(),
                            )..shimmer(
                                color: theme.shimmerColor,
                                duration: const Duration(seconds: 1),
                              ),
                          ),
                          SizedBox(width: context.horizontalMargin4),
                          ShimmerLabel(width: 24.w, height: 13.h).animate(
                            onComplete: (controller) => controller.repeat(),
                          )..shimmer(
                              color: theme.shimmerColor,
                              duration: const Duration(seconds: 1),
                            ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: context.verticalMargin12),
                  ListView.separated(
                    padding: EdgeInsets.zero,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: context.verticalMargin20);
                    },
                    itemCount: 6,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: ShimmerLabel(width: 72.w, height: 11.h).animate(
                                onComplete: (controller) => controller.repeat(),
                              )..shimmer(
                                  color: theme.shimmerColor,
                                  duration: const Duration(seconds: 1),
                                ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 8.h,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) => SizedBox(width: context.horizontalMargin1),
                                  itemBuilder: (_, index) {
                                    return Container(
                                      color: theme.textPrimary,
                                      child: SizedBox(
                                        width: 6.w,
                                        height: 8.h,
                                      ),
                                    ).animate(
                                      onComplete: (controller) => controller.repeat(),
                                    )..shimmer(
                                        color: theme.shimmerColor,
                                        duration: const Duration(seconds: 1),
                                      );
                                  },
                                  itemCount: 10,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: SizedBox(
                                height: 8.h,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) => SizedBox(width: context.horizontalMargin1),
                                  itemBuilder: (_, index) {
                                    return Container(
                                      color: theme.textPrimary,
                                      child: SizedBox(
                                        width: 6.w,
                                        height: 8.h,
                                      ),
                                    ).animate(
                                      onComplete: (controller) => controller.repeat(),
                                    )..shimmer(
                                        color: theme.shimmerColor,
                                        duration: const Duration(seconds: 1),
                                      );
                                  },
                                  itemCount: 10,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
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
