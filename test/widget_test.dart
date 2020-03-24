import 'package:flutter_test/flutter_test.dart';
import 'package:kawal_corona/connection/kawalCoronaHttp.dart';

main() {
  group('API Test', () {
    test('Indonesia API', () async {
      print(await KawalCoronaHttp().getStatusIndonesia());
    });
    test('Sembuh Dunia API', () async {
      print(await KawalCoronaHttp().getSembuh());
    });
    test('Terinfeksi Dunia API', () async {
      print(await KawalCoronaHttp().getPositif());
    });
    test('Meninggal Dunia API', () async {
      print(await KawalCoronaHttp().getMeninggal());
    });
    test('Data Dunia API', () async {
      print(await KawalCoronaHttp().getStatusDunia());
    });
    test('Data Provinsi API', () async {
      print(await KawalCoronaHttp().getStatusProvinsi());
    });
  });
}
