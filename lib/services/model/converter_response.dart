part of services;

class ConverterResponse {
  final String result;
  final String documentation;
  final String termsOfUse;
  final int timeLastUpdateUnix;
  final String timeLastUpdateUtc;
  final int timeNextUpdateUnix;
  final String timeNextUpdateUtc;
  final String baseCode;
  final String targetCode;
  final double conversionRate;
  final double conversionResult;

  ConverterResponse({
    required this.result,
    required this.documentation,
    required this.termsOfUse,
    required this.timeLastUpdateUnix,
    required this.timeLastUpdateUtc,
    required this.timeNextUpdateUnix,
    required this.timeNextUpdateUtc,
    required this.baseCode,
    required this.targetCode,
    required this.conversionRate,
    required this.conversionResult,
  });

  ConverterResponse copyWith({
    String? result,
    String? documentation,
    String? termsOfUse,
    int? timeLastUpdateUnix,
    String? timeLastUpdateUtc,
    int? timeNextUpdateUnix,
    String? timeNextUpdateUtc,
    String? baseCode,
    String? targetCode,
    double? conversionRate,
    double? conversionResult,
  }) {
    return ConverterResponse(
      result: result ?? this.result,
      documentation: documentation ?? this.documentation,
      termsOfUse: termsOfUse ?? this.termsOfUse,
      timeLastUpdateUnix: timeLastUpdateUnix ?? this.timeLastUpdateUnix,
      timeLastUpdateUtc: timeLastUpdateUtc ?? this.timeLastUpdateUtc,
      timeNextUpdateUnix: timeNextUpdateUnix ?? this.timeNextUpdateUnix,
      timeNextUpdateUtc: timeNextUpdateUtc ?? this.timeNextUpdateUtc,
      baseCode: baseCode ?? this.baseCode,
      targetCode: targetCode ?? this.targetCode,
      conversionRate: conversionRate ?? this.conversionRate,
      conversionResult: conversionResult ?? this.conversionResult,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'result': result});
    result.addAll({'documentation': documentation});
    result.addAll({'terms_of_use': termsOfUse});
    result.addAll({'time_last_update_unix': timeLastUpdateUnix});
    result.addAll({'time_last_update_utc': timeLastUpdateUtc});
    result.addAll({'time_next_update_unix': timeNextUpdateUnix});
    result.addAll({'time_next_update_utc': timeNextUpdateUtc});
    result.addAll({'base_code': baseCode});
    result.addAll({'target_code': targetCode});
    result.addAll({'conversion_rate': conversionRate});
    result.addAll({'conversion_result': conversionResult});

    return result;
  }

  factory ConverterResponse.fromMap(Map<String, dynamic> map) {
    return ConverterResponse(
      result: map['result'] ?? '',
      documentation: map['documentation'] ?? '',
      termsOfUse: map['terms_of_use'] ?? '',
      timeLastUpdateUnix: map['time_last_update_unix']?.toInt() ?? 0,
      timeLastUpdateUtc: map['time_last_update_utc'] ?? '',
      timeNextUpdateUnix: map['time_next_update_unix']?.toInt() ?? 0,
      timeNextUpdateUtc: map['time_next_update_utc'] ?? '',
      baseCode: map['base_code'] ?? '',
      targetCode: map['target_code'] ?? '',
      conversionRate: map['conversion_rate']?.toDouble() ?? 0.0,
      conversionResult: map['conversion_result']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ConverterResponse.fromJson(String source) => ConverterResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ConverterResponse(result: $result, documentation: $documentation, termsOfUse: $termsOfUse, timeLastUpdateUnix: $timeLastUpdateUnix, timeLastUpdateUtc: $timeLastUpdateUtc, timeNextUpdateUnix: $timeNextUpdateUnix, timeNextUpdateUtc: $timeNextUpdateUtc, baseCode: $baseCode, targetCode: $targetCode, conversionRate: $conversionRate, conversionResult: $conversionResult)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ConverterResponse &&
        other.result == result &&
        other.documentation == documentation &&
        other.termsOfUse == termsOfUse &&
        other.timeLastUpdateUnix == timeLastUpdateUnix &&
        other.timeLastUpdateUtc == timeLastUpdateUtc &&
        other.timeNextUpdateUnix == timeNextUpdateUnix &&
        other.timeNextUpdateUtc == timeNextUpdateUtc &&
        other.baseCode == baseCode &&
        other.targetCode == targetCode &&
        other.conversionRate == conversionRate &&
        other.conversionResult == conversionResult;
  }

  @override
  int get hashCode {
    return result.hashCode ^
        documentation.hashCode ^
        termsOfUse.hashCode ^
        timeLastUpdateUnix.hashCode ^
        timeLastUpdateUtc.hashCode ^
        timeNextUpdateUnix.hashCode ^
        timeNextUpdateUtc.hashCode ^
        baseCode.hashCode ^
        targetCode.hashCode ^
        conversionRate.hashCode ^
        conversionResult.hashCode;
  }
}
