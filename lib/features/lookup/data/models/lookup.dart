import 'package:tscore/features/lookup/domain/entities/lookup.dart';

class Lookup extends LookupEntity {
  Lookup({
    required super.id,
    required super.dataKey,
    required super.displayText,
    required super.dataValue,
  });

  factory Lookup.parse({required Map<String, dynamic> map}) {
    return Lookup(
      id: map['id'],
      dataKey: map['dataKey'],
      displayText: map['displayText'],
      dataValue: map['dataValue'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dataKey': dataKey,
      'displayText': displayText,
      'dataValue': dataValue,
    };
  }
}
