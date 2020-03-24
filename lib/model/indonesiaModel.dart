import 'model.dart';

class Indonesia extends Model {
  String name;
  String positif;
  String sembuh;
  String meninggal;

  Indonesia({
    this.name,
    this.positif,
    this.sembuh,
    this.meninggal,
  });

  factory Indonesia.fromJson(Map<String, dynamic> json) => Indonesia(
        name: json["name"] == null ? null : json["name"],
        positif: json["positif"] == null ? null : json["positif"],
        sembuh: json["sembuh"] == null ? null : json["sembuh"],
        meninggal: json["meninggal"] == null ? null : json["meninggal"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "positif": positif == null ? null : positif,
        "sembuh": sembuh == null ? null : sembuh,
        "meninggal": meninggal == null ? null : meninggal,
      };
}
