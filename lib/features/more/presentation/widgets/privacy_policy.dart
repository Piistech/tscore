import '../../../../core/shared/shared.dart';

class PrivacyPolicyPage extends StatelessWidget {
  static const String path = '/privacyPolicyPage';
  static const String name = 'PrivacyPolicyPage';
  final String headerText;
  final String link;

  const PrivacyPolicyPage({super.key, required this.headerText, required this.link});
 Future<String> get _url async {
    await Future.delayed(const Duration(seconds: 1));
    return link;
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.backgroundPrimary,
          appBar: AppBar(
            backgroundColor: theme.backgroundPrimary,
            automaticallyImplyLeading: true,
            title: Text(
              "T Score Radio $headerText",
              style: TextStyles.title(context: context, color: theme.textPrimary),
            ),
          ),
          body: FutureBuilder(
            future: _url,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return WebViewWidget(
                  controller: WebViewController()
                    ..loadRequest(
                      Uri.parse(link),
                    ),
                );
              } else {
                return Container();
              }
            },
          ),
        );
      },
    );
  }
}
