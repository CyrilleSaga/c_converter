part of 'handle_converter_bloc.dart';

sealed class HandleConverterState extends Equatable {
  const HandleConverterState();

  @override
  List<Object> get props => [];
}

final class HandleConverterInitial extends HandleConverterState {}

final class HandleConverterLoading extends HandleConverterState {}

final class HandleConverterLoaded extends HandleConverterState {
  final ConverterResponse conversionResponse;

  const HandleConverterLoaded({
    required this.conversionResponse,
  });

  @override
  List<Object> get props => [conversionResponse];
}
