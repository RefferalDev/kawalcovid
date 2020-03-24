import 'package:kawal_corona/model/model.dart';

class ValueApi extends Model {
  String name;
  String value;

  ValueApi({
    this.name,
    this.value,
  });

  factory ValueApi.fromJson(Map<String, dynamic> json) => ValueApi(
        name: json["name"] == null ? null : json["name"],
        value: json["value"] == null ? null : json["value"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "value": value == null ? null : value,
      };
}
