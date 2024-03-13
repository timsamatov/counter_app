import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:counter_app/data/model.dart';
import 'package:counter_app/presentation/blocs/counter_bloc/counter_state.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(0, '')) {
    on<Increment>((event, emit) {
      if (state.count < 10) {
        emit(CounterState(state.count + 1, state.weather));
      }
    });
    on<Decrement>((event, emit) {
      if (state.count > 0) {
        emit(CounterState(state.count - 1, state.weather));
      }
    });
    on<GethWeather>((event, emit) async {
      try {
        const apiUrl =
            'https://api.openweathermap.org/data/2.5/weather?lat=42.882004&lon=74.582748&appid={45bed05cc16dc43ee124ad15485f93cf}';
        final response = await http.get(Uri.parse(apiUrl));
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          final weatherModel = WeatherModel.fromJson(jsonData);
          final weather = weatherModel.weather?[0]?.main ?? '';
          emit(CounterState(state.count, weather));
        } else {
          throw Exception('Не удалось загрузить данные о погоде');
        }
      } catch (e) {
        emit(CounterState(state.count, 'Не удалось загрузить данные о погоде'));
      }
    });
  }

  get http => null;
}
