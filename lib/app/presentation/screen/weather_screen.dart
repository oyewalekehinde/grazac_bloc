import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grazac_bloc/app/data/model/weather_model.dart';
import 'package:grazac_bloc/app/data/service/weather_service.dart';
import 'package:grazac_bloc/app/presentation/bloc/weather_bloc.dart';
import 'package:tuple/tuple.dart';

class WeatherScreen extends StatelessWidget {
  final WeatherBloc weatherBloc = WeatherBloc();
  WeatherScreen({Key? key}) : super(key: key);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextButton(
                onPressed: () async {
                  weatherBloc.add(GetWeatherByCity(city: "Lagos"));
                },
                child: Text("Make api call"),
              ),
              BlocConsumer(
                bloc: weatherBloc,
                listener: (context, state) {
                  if (state is WeatherLoading) {
                  } else if (state is WeatherSuccess) {
                    _scaffoldKey.currentState!.showSnackBar(
                        new SnackBar(content: new Text('i am successfull')));
                  } else if (state is WeatherFailed) {}
                },
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return CircularProgressIndicator.adaptive();
                  } else if (state is WeatherSuccess) {
                    return WeatherSuccessWidget(
                      data: state.response,
                    );
                  } else if (state is WeatherFailed) {
                    return Text(state.error!);
                  }
                  return Container();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  final String? value;
  final String? name;
  ContainerWidget({
    Key? key,
    this.value,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text(value!), Text(name!)],
    );
  }
}

class WeatherSuccessWidget extends StatelessWidget {
  final WeatherModel? data;
  const WeatherSuccessWidget({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    data!.name!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "${data!.main!.temp!.ceil() - 273}°",
                    style: TextStyle(
                      fontSize: 80,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Transform.rotate(
                  angle: -pi / 2,
                  child: Text(
                    "it's ${data!.weather![0].description!}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ))
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Spacer(),
          Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ContainerWidget(
                  value: "78%",
                  name: "Humidity",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: VerticalDivider(),
                ),
                ContainerWidget(
                  value: "11km",
                  name: "Visibility",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  child: VerticalDivider(),
                ),
                ContainerWidget(
                  value: "Low",
                  name: "UVIndex",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
