part of 'weather_bloc.dart';

@immutable
abstract class WeatherState extends Equatable {
  const WeatherState();
  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSuccess extends WeatherState {
  final WeatherModel? response;
  WeatherSuccess({
    this.response,
  });
}

class WeatherFailed extends WeatherState {
  final String? error;
  WeatherFailed({
    this.error,
  });
}
