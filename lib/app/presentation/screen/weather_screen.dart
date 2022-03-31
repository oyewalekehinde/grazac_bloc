import 'dart:math';

import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "NEW ZEALAND",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "-9°",
                        style: TextStyle(
                          fontSize: 120,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Transform.rotate(
                      angle: -pi / 2,
                      child: Text(
                        "it's Sunny",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ))
                ],
              ),
              Spacer(),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: Colors.grey.withOpacity(0.3), width: 2),
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
