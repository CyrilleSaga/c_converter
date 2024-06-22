part of 'handle_converter_bloc.dart';

sealed class HandleConverterEvent extends Equatable {
  const HandleConverterEvent();

  @override
  List<Object> get props => [];
}

final class GetConversionRateEvent extends HandleConverterEvent {
  final String fromCode;
  final String toCode;
  final double amount;

  const GetConversionRateEvent({
    required this.fromCode,
    required this.toCode,
    required this.amount,
  });

  @override
  List<Object> get props => [fromCode, toCode, amount];
}
