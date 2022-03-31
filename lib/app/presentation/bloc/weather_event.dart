part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
  @override
  List<Object> get props => [];
}

class GetWeatherByCity extends WeatherEvent {
  final String? city;
  GetWeatherByCity({this.city});
}
