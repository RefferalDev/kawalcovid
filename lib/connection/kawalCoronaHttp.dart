import 'package:kawal_corona/connection/HttpConnection.dart';
import 'package:kawal_corona/model/countryApiModel.dart';
import 'package:kawal_corona/model/indonesiaModel.dart';
import 'package:kawal_corona/model/provinceApiModel.dart';
import 'package:kawal_corona/model/valueApiModel.dart';
import 'package:kawal_corona/res/environment.dart';

class KawalCoronaHttp extends HttpConnection {
  Future<Indonesia> getStatusIndonesia() async {
    print(await get(endpoint + "indonesia/"));
    return Indonesia.fromJson((await get(endpoint + "indonesia/")).first);
  }

  Future<List<ProvinceApi>> getStatusProvinsi() async {
    List<ProvinceApi> output = (await get(endpoint + "indonesia/provinsi/"))
        .map((item) {
          var output = ProvinceApi.fromJson(item);
          return output;
        })
        .toList()
        .cast<ProvinceApi>();
    return output;
  }

  Future<List<CountryApi>> getStatusDunia() async {
    return (await get(endpoint)).map((item) => CountryApi.fromJson(item)).toList().cast<CountryApi>();
  }

  Future<ValueApi> getSembuh() async {
    return ValueApi.fromJson(await get(endpoint + "sembuh/"));
  }

  Future<ValueApi> getPositif() async {
    return ValueApi.fromJson(await get(endpoint + "positif/"));
  }

  Future<ValueApi> getMeninggal() async {
    return ValueApi.fromJson(await get(endpoint + "meninggal/"));
  }
}
