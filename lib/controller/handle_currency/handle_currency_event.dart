part of 'handle_currency_bloc.dart';

sealed class HandleCurrencyEvent extends Equatable {
  const HandleCurrencyEvent();

  @override
  List<Object> get props => [];
}

final class FetchCurrenciesEvent extends HandleCurrencyEvent {}

final class SwicthCurrenciesEvent extends HandleCurrencyEvent {
  final String fromCode;
  final String toCode;

  const SwicthCurrenciesEvent({
    required this.fromCode,
    required this.toCode,
  });

  @override
  List<Object> get props => [fromCode, toCode];
}
