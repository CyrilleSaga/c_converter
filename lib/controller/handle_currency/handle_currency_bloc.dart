import 'package:c_converter/services/api.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'handle_currency_event.dart';
part 'handle_currency_state.dart';

class HandleCurrencyBloc extends HydratedBloc<HandleCurrencyEvent, HandleCurrencyState> {
  HandleCurrencyBloc() : super(HandleCurrencyInitial()) {
    on<FetchCurrenciesEvent>((event, emit) async {
      emit(HandleCurrencyLoading());
      await DefaultApi().getCurrencies().then((currencies) {
        emit(
          HandleCurrencyLoaded(
            currencies: currencies,
            selectedFromCurrency: currencies[0],
            selectedToCurrency: currencies[1],
          ),
        );
      });
    });
    on<SwicthCurrenciesEvent>((event, emit) async {
      await DefaultApi().getCurrencies().then((currencies) {
        emit(
          HandleCurrencyLoaded(
            currencies: currencies,
            selectedFromCurrency: currencies.firstWhere((element) => element.code == event.toCode),
            selectedToCurrency: currencies.firstWhere((element) => element.code == event.fromCode),
          ),
        );
      });
    });
  }

  @override
  HandleCurrencyState? fromJson(Map<String, dynamic> json) {
    if (json['currencies'] != null) {
      return HandleCurrencyLoaded(
        currencies: Currency.listFromJson(json['currencies']),
        selectedFromCurrency: json['selectedFromCurrency'] as Currency,
        selectedToCurrency: json['selectedToCurrency'] as Currency,
      );
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(HandleCurrencyState state) {
    if (state is HandleCurrencyLoaded) {
      return {
        'currencies': state.currencies.map((e) => e.toMap()).toList(),
        'selectedFromCurrency': state.selectedFromCurrency,
        'selectedToCurrency': state.selectedToCurrency,
      };
    }
    return null;
  }
}
