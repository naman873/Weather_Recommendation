import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controller/weather_controller.dart';

class VacationListScreen extends StatefulWidget {
  const VacationListScreen({super.key});

  @override
  State<VacationListScreen> createState() => _VacationListScreenState();
}

class _VacationListScreenState extends State<VacationListScreen> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather Best For U :)"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: "Enter Cities with , separate",
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Color(0xff635C5C),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 4,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Provider.of<WeatherController>(context, listen: false)
                      .getAllWeathers(textController.text);
                },
                child: const Text(
                  "Get Details",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(color: Colors.grey),
              const SizedBox(height: 10),
              Consumer<WeatherController>(
                builder: (context, weatherData, child) {
                  return weatherData.loader == false
                      ? weatherData.weatherData.isNotEmpty
                          ? Expanded(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: weatherData.weatherData.length,
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 10);
                                },
                                itemBuilder: (context, index) {
                                  var item = weatherData.weatherData[index];
                                  return Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          item.weather?[0].main
                                                      ?.toLowerCase() ==
                                                  "smoke"
                                              ? "assets/smoke.jpg"
                                              : item.weather?[0].main
                                                          ?.toLowerCase() ==
                                                      "clouds"
                                                  ? "assets/cloudy.jpg"
                                                  : item.weather?[0].main
                                                              ?.toLowerCase() ==
                                                          "clear"
                                                      ? "assets/sunny.jpg"
                                                      : "assets/smoke.jpg",
                                          height: 100,
                                          width: 100,
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.name ?? "",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: Colors.black45),
                                            ),
                                            Text(
                                              "Temp: ${item.main?.temp.toString()}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              "Wind Speed: ${item.wind?.speed.toString()}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              "Des: ${item.weather?[0].description.toString()}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            (item.wind?.speed ?? 0) < 7 &&
                                                    ((item.main?.temp ?? 0) >
                                                            10 &&
                                                        (item.main?.temp ?? 0) <
                                                            37)
                                                ? Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors
                                                              .transparent),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.green,
                                                    ),
                                                    child: const Text(
                                                      "Recommended",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 14,
                                                          color: Colors.white),
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          : const Center(
                              child: Text("Your Cities List"),
                            )
                      : const CircularProgressIndicator();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
