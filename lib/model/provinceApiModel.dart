import 'package:kawal_corona/model/model.dart';

class ProvinceApi extends Model {
  Attributes attributes;

  ProvinceApi({
    this.attributes,
  });

  factory ProvinceApi.fromJson(Map<String, dynamic> json) => ProvinceApi(
        attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "attributes": attributes == null ? null : attributes.toJson(),
      };
}

class Attributes extends Model {
  int fid;
  int kodeProvi;
  String provinsi;
  int kasusPosi;
  int kasusSemb;
  int kasusMeni;

  Attributes({
    this.fid,
    this.kodeProvi,
    this.provinsi,
    this.kasusPosi,
    this.kasusSemb,
    this.kasusMeni,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        fid: json["FID"] == null ? null : json["FID"],
        kodeProvi: json["Kode_Provi"] == null ? null : json["Kode_Provi"],
        provinsi: json["Provinsi"] == null ? null : json["Provinsi"],
        kasusPosi: json["Kasus_Posi"] == null ? null : json["Kasus_Posi"],
        kasusSemb: json["Kasus_Semb"] == null ? null : json["Kasus_Semb"],
        kasusMeni: json["Kasus_Meni"] == null ? null : json["Kasus_Meni"],
      );
  @override
  Map<String, dynamic> toJson() => {
        "FID": fid == null ? null : fid,
        "Kode_Provi": kodeProvi == null ? null : kodeProvi,
        "Provinsi": provinsi == null ? null : provinsi,
        "Kasus_Posi": kasusPosi == null ? null : kasusPosi,
        "Kasus_Semb": kasusSemb == null ? null : kasusSemb,
        "Kasus_Meni": kasusMeni == null ? null : kasusMeni,
      };
}
