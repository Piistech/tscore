part of 'lookup_bloc.dart';

abstract class LookupEvent extends Equatable {
  const LookupEvent();

  @override
  List<Object> get props => [];
}

class FetchLookup extends LookupEvent {
  final String key;
  const FetchLookup({required this.key});
}
