import '../shared.dart';

extension BuildContextExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  Color get primaryColor => theme.primaryColor;

  Color get hintColor => theme.hintColor;

  Color get textColor => Colors.black;

  Color get secondaryColor => theme.cardColor;

  Color get backgroundColor => Colors.white;

  double get topInset => MediaQuery.of(this).padding.top;

  double get bottomInset => MediaQuery.of(this).padding.bottom;

  double get smallestSide => MediaQuery.of(this).size.shortestSide;
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  ScaffoldMessengerState successNotification({
    required String message,
  }) {
    final theme = themeBloc.state.scheme;
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyles.body(context: this, color: theme.textPrimary),
      ),
      backgroundColor: theme.positive,
    );
    return ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  ScaffoldMessengerState errorNotification({
    required String message,
  }) {
    final theme = themeBloc.state.scheme;
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyles.body(context: this, color: theme.textPrimary),
      ),
      backgroundColor: theme.negative,
    );
    return ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  ScaffoldMessengerState warningNotification({
    required String message,
  }) {
    final theme = themeBloc.state.scheme;
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyles.body(context: this, color: theme.backgroundPrimary),
      ),
      backgroundColor: theme.warning,
    );
    return ScaffoldMessenger.of(this)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  ThemeBloc get themeBloc => this.read<ThemeBloc>();

  TextStyle textStyle17Medium({required Color color}) => GoogleFonts.rubik(
        textStyle: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      );

  TextStyle textStyle12Medium({required Color color}) => GoogleFonts.rubik(
        textStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      );

  TextStyle textStyle10Regular({required Color color}) => GoogleFonts.rubik(
        textStyle: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.normal,
          color: color,
        ),
      );
  TextStyle textStyle10Medium({required Color color}) => GoogleFonts.rubik(
        textStyle: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      );

  double get radius5 => 5.r;
  double get radius8 => 8.r;
  double get radius12 => 12.r;

  double get horizontalMargin4 => 4.w;
  double get horizontalMargin6 => 6.w;
  double get horizontalMargin8 => 8.w;
  double get horizontalMargin12 => 12.w;
  double get horizontalMargin15 => 15.w;
  double get horizontalMargin16 => 16.w;

  double get verticalMargin4 => 4.h;
  double get verticalMargin6 => 6.h;
  double get verticalMargin8 => 8.h;
  double get verticalMargin12 => 12.h;
  double get verticalMargin15 => 15.h;
  double get verticalMargin16 => 16.h;
}
