part of 'handle_currency_bloc.dart';

sealed class HandleCurrencyEvent extends Equatable {
  const HandleCurrencyEvent();

  @override
  List<Object> get props => [];
}

final class FetchCurrenciesEvent extends HandleCurrencyEvent {}
