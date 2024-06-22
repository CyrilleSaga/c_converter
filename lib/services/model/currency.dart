part of services;

class Currency {
  final String code;
  final String name;
  Currency({
    required this.code,
    required this.name,
  });

  Currency copyWith({
    String? code,
    String? name,
  }) {
    return Currency(
      code: code ?? this.code,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'code': code});
    result.addAll({'name': name});

    return result;
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      code: map['code'] ?? '',
      name: map['name'] ?? '',
    );
  }

  static List<Currency> listFromJson(List<dynamic> list) {
    return list.map((e) => Currency.fromMap(e)).toList();
  }

  String toJson() => json.encode(toMap());

  factory Currency.fromJson(String source) => Currency.fromMap(json.decode(source));

  @override
  String toString() => 'Currency(code: $code, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Currency && other.code == code && other.name == name;
  }

  @override
  int get hashCode => code.hashCode ^ name.hashCode;
}
