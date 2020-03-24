import 'package:kawal_corona/model/model.dart';

class CountryApi extends Model {
  Attributes attributes;

  CountryApi({
    this.attributes,
  });

  factory CountryApi.fromJson(Map<String, dynamic> json) => CountryApi(
        attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "attributes": attributes == null ? null : attributes.toJson(),
      };
}

class Attributes extends Model {
  int objectid;
  String countryRegion;
  int lastUpdate;
  double lat;
  double long;
  int confirmed;
  int deaths;
  int recovered;
  int active;

  Attributes({
    this.objectid,
    this.countryRegion,
    this.lastUpdate,
    this.lat,
    this.long,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.active,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        objectid: json["OBJECTID"] == null ? null : json["OBJECTID"],
        countryRegion: json["Country_Region"] == null ? null : json["Country_Region"],
        lastUpdate: json["Last_Update"] == null ? null : json["Last_Update"],
        lat: json["Lat"] == null ? null : json["Lat"].toDouble(),
        long: json["Long_"] == null ? null : json["Long_"].toDouble(),
        confirmed: json["Confirmed"] == null ? null : json["Confirmed"],
        deaths: json["Deaths"] == null ? null : json["Deaths"],
        recovered: json["Recovered"] == null ? null : json["Recovered"],
        active: json["Active"] == null ? null : json["Active"],
      );
  @override
  Map<String, dynamic> toJson() => {
        "OBJECTID": objectid == null ? null : objectid,
        "Country_Region": countryRegion == null ? null : countryRegion,
        "Last_Update": lastUpdate == null ? null : lastUpdate,
        "Lat": lat == null ? null : lat,
        "Long_": long == null ? null : long,
        "Confirmed": confirmed == null ? null : confirmed,
        "Deaths": deaths == null ? null : deaths,
        "Recovered": recovered == null ? null : recovered,
        "Active": active == null ? null : active,
      };
}
