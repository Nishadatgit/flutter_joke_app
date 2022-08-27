import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  @JsonKey(name: 'cloud_pct')
  int? cloudPct;
  @JsonKey(name: 'temp')
  int? temp;
  @JsonKey(name: 'feels_like')
  int? feelsLike;
  @JsonKey(name: 'humidity')
  int? humidity;
  @JsonKey(name: 'min_temp')
  int? minTemp;
  @JsonKey(name: 'max_temp')
  int? maxTemp;
  @JsonKey(name: 'wind_speed')
  double? windSpeed;
  @JsonKey(name: 'wind_degrees')
  int? windDegrees;
  @JsonKey(name: 'sunrise')
  int? sunrise;
  @JsonKey(name: 'sunset')
  int? sunset;

  WeatherModel({
    this.cloudPct,
    this.temp,
    this.feelsLike,
    this.humidity,
    this.minTemp,
    this.maxTemp,
    this.windSpeed,
    this.windDegrees,
    this.sunrise,
    this.sunset,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return _$WeatherModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}
