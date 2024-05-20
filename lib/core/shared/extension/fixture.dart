import 'package:intl/intl.dart';

import '../../../features/fixture/fixture.dart';

extension FixtureEntityExtension on FixtureEntity {
  String get title {
    return '$matchTitle, $matchDescription';
  }

  bool get isLive {
    return (result == "" &&
        isCompleted == false &&
        (startedAt.isBefore(DateTime.now()) || startedAt.isAtSameMomentAs(DateTime.now())));
  }

  bool get isUpcoming {
    final now = DateTime.now();
    return (now.day < startedAt.day && now.month == startedAt.month && now.year == startedAt.year);
  }

  bool get isToday {
    final now = DateTime.now();
    return !isLive && (now.day == startedAt.day && now.month == startedAt.month && now.year == startedAt.year);
  }

  bool get isTomorrow {
    final now = DateTime.now();
    return (now.day + 1 == startedAt.day && now.month == startedAt.month && now.year == startedAt.year);
  }

  bool get isPast {
    final now = DateTime.now();
    return (now.day > startedAt.day);
  }

  bool get isFinished {
    return !isLive && !isUpcoming && (result != "" || result != null) && isCompleted;
  }

  String get startTime {
    return 'Starts at ${DateFormat("h:mm a").format(startedAt)}';
  }

  String get startDate {
    return DateFormat("dd MMMM yyyy, EEEE").format(startedAt);
  }
}
