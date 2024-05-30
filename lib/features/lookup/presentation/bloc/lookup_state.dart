part of 'lookup_bloc.dart';

abstract class LookupState extends Equatable {
  const LookupState();

  @override
  List<Object> get props => [];
}

class LookupInitial extends LookupState {}

class LookupLoading extends LookupState {
  const LookupLoading();
}

class LookupDone extends LookupState {
  final List<LookupEntity> lookups;
   const LookupDone(
    {
      required this.lookups
    }
   );
}

class LookupError extends LookupState {
  final Failure failure;

  const LookupError({required this.failure});
}
