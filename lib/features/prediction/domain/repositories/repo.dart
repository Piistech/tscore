

import 'package:either_dart/either.dart';

import '../../../../core/shared/shared.dart';
import '../../prediction.dart';

abstract class PredictionRepository {
  Future<Either<Failure, PredictionEntity>> fetch({
    required String fixtureGuid,
  });
}
