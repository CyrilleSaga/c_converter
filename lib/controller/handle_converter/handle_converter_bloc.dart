import 'package:bloc/bloc.dart';
import 'package:c_converter/services/api.dart';
import 'package:equatable/equatable.dart';

part 'handle_converter_event.dart';
part 'handle_converter_state.dart';

class HandleConverterBloc extends Bloc<HandleConverterEvent, HandleConverterState> {
  DefaultApi api = DefaultApi();
  HandleConverterBloc() : super(HandleConverterInitial()) {
    on<GetConversionRateEvent>((event, emit) async {
      emit(HandleConverterLoading());
      await api
          .getConversionRate(
        fromCode: event.fromCode,
        toCode: event.toCode,
        amount: event.amount,
      )
          .then((response) {
        emit(HandleConverterLoaded(conversionResponse: response));
      });
    });
  }
}
