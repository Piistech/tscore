import 'package:intl/intl.dart';

import '../../../features/fixture/domain/entities/fixtures.dart';

extension FixtureEntityExtension on FixturesEntity {
  String get title {
    return matchTitle;
  }

  bool get isLive {
    return (result == "" &&
        isCompleted == false &&
        isCommentrySetupOk &&
        (startedAt.isBefore(DateTime.now()) || startedAt.isAtSameMomentAs(DateTime.now())));
  }

  bool get isUpcoming {
    final now = DateTime.now();
    return !isToday && (startedAt.isAfter(now));
  }

  bool get isToday {
    final now = DateTime.now();
    return (now.day == startedAt.day && now.month == startedAt.month && now.year == startedAt.year);
  }

  bool get willLiveToday {
    return !isLive && isToday;
  }

  bool get isTomorrow {
    final now = DateTime.now();
    final DateTime tomorrow = now.add(const Duration(days: 1));
    return (tomorrow.day == startedAt.day && tomorrow.month == startedAt.month && tomorrow.year == startedAt.year);
  }

  bool get isPast {
    return !isToday && !isTomorrow && !isUpcoming;
  }

  bool get isOnGoing {
    return result != "" && isCompleted && isCommentrySetupOk && !isLive;
  }

  String get startTime {
    return 'Starts at ${DateFormat("h:mm a").format(startedAt)}';
  }

  String get startDate {
    return DateFormat("dd MMMM yyyy, EEE 'at' hh:mm a").format(startedAt);
  }
}
