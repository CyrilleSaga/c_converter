part of 'handle_currency_bloc.dart';

sealed class HandleCurrencyState extends Equatable {
  const HandleCurrencyState();

  @override
  List<Object> get props => [];
}

final class HandleCurrencyInitial extends HandleCurrencyState {}

final class HandleCurrencyLoading extends HandleCurrencyState {}

final class HandleCurrencyLoaded extends HandleCurrencyState {
  final List<Currency> currencies;
  final Currency selectedFromCurrency;
  final Currency selectedToCurrency;

  const HandleCurrencyLoaded({
    required this.currencies,
    required this.selectedFromCurrency,
    required this.selectedToCurrency,
  });

  @override
  List<Object> get props => [currencies, selectedFromCurrency, selectedToCurrency];
}
