import '../../../../../core/shared/shared.dart';
import '../../../../live_audio/presentation/widgets/shimmer/item.dart';

class ShimmerFixture extends StatelessWidget {
  const ShimmerFixture({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.horizontalMargin16, vertical: context.verticalMargin16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmerLabel(
            width: 64,
            height: 17,
            radius: context.radius10,
          ),
          SizedBox(height: context.verticalMargin10),
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return ShimmerLabel(
                width: 329.w,
                height: 150.h,
                radius: context.radius10,
              ).animate(
                onComplete: (controller) => controller.repeat(),
              )..shimmer(
                  color: state.scheme.shimmerColor,
                  duration: const Duration(seconds: 1),
                );
            },
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (_, __) => SizedBox(height: context.verticalMargin10),
              itemCount: 4,
              itemBuilder: (_, __) => const ShimmerItem(),
            ),
          ),
        ],
      ),
    );
  }
}
