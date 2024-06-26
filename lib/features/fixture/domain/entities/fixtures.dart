import 'package:equatable/equatable.dart';

class FixturesEntity extends Equatable {
  final String guid;
  final String matchTitle;
  final String matchDescription;
  final DateTime startedAt;
  final String? result;
  final String homeTeamId;
  final String awayTeamId;
  final String stadiumName;
  final String logo;
  final bool isCompleted;
  final bool isCommentrySetupOk;
  final bool isPredictionAvailable;

  const FixturesEntity({
    required this.guid,
    required this.matchTitle,
    required this.matchDescription,
    required this.startedAt,
    required this.result,
    required this.homeTeamId,
    required this.awayTeamId,
    required this.stadiumName,
    required this.logo,
    required this.isCompleted,
    required this.isCommentrySetupOk,
    required this.isPredictionAvailable,
  });

  @override
  List<Object?> get props => [
        guid,
        matchTitle,
        matchDescription,
        startedAt,
        result,
        homeTeamId,
        awayTeamId,
        stadiumName,
        logo,
        isCompleted,
        isCommentrySetupOk,
        isPredictionAvailable,
      ];
}
