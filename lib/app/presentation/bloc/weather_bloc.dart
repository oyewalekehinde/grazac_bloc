import 'package:bloc/bloc.dart';
import 'package:grazac_bloc/app/data/model/weather_model.dart';
import 'package:grazac_bloc/app/data/service/weather_service.dart';
import 'package:meta/meta.dart';
import 'package:tuple/tuple.dart';
import 'package:equatable/equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      if (event is GetWeatherByCity) {
        emit(WeatherLoading());
        Tuple2<WeatherModel?, String?> result =
            await WeatherService().getWeatherByCity(city: event.city);
        if (result.item1 != null) {
          emit(WeatherSuccess(response: result.item1));
        } else {
          emit(WeatherFailed(error: result.item2));
        }
      }
    });
  }
}
