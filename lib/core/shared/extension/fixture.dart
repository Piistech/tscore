import 'package:intl/intl.dart';

import '../../../features/fixture/domain/entities/fixtures.dart';

extension FixtureEntityExtension on FixturesEntity {
  String get title {
    return '$matchTitle, $matchDescription';
  }

  bool get isLive {
    return (result == "" &&
        isCompleted == false &&
        isCommentrySetupOk &&
        (startedAt.isBefore(DateTime.now()) || startedAt.isAtSameMomentAs(DateTime.now())));
  }

  bool get isUpcoming {
    final now = DateTime.now();
    //return (now.day < startedAt.day && now.month <= startedAt.month && now.year <= startedAt.year);
    return (now.isBefore(startedAt));
  }

  bool get isToday {
    final now = DateTime.now();
    return (now.day == startedAt.day && now.month == startedAt.month && now.year == startedAt.year);
  }

  bool get willLiveToday {
    final now = DateTime.now();
    return !isLive &&
        (now.day == startedAt.day) &&
        (now.hour < startedAt.hour);
  }

  bool get isTomorrow {
    final now = DateTime.now();
    return (now.day + 1 == startedAt.day && now.month == startedAt.month && now.year == startedAt.year);
  }

  bool get isPast {
    final now = DateTime.now();
    return (now.isAfter(startedAt));
  }

  bool get isOnGoing {
    return result != "" && isCompleted && isCommentrySetupOk && !isLive;
  }

  String get startTime {
    return 'Starts at ${DateFormat("h:mm a").format(startedAt)}';
  }

  String get startDate {
    return DateFormat("dd MMMM yyyy, EEEE 'at' hh:mm a").format(startedAt);
  }
}
