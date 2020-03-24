import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:kawal_corona/components/customCard.dart';
import 'package:kawal_corona/components/customDivider.dart';
import 'package:kawal_corona/components/infoCard.dart';
import 'package:kawal_corona/connection/kawalCoronaHttp.dart';
import 'package:kawal_corona/model/countryApiModel.dart';
import 'package:kawal_corona/model/valueApiModel.dart';
import 'package:latlong/latlong.dart';
import 'package:loading_animations/loading_animations.dart';

class KasusDuniaPage extends StatefulWidget {
  @override
  _KasusDuniaPageState createState() => _KasusDuniaPageState();
}

class _KasusDuniaPageState extends State<KasusDuniaPage> {
  final MapController _controller = MapController();
  List<CountryApi> _listCorona = [];

  void getListCorona() async {
    _listCorona = (await KawalCoronaHttp().getStatusDunia()) ?? [];
    setState(() {});
  }

  @override
  void initState() {
    getListCorona();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FlutterMap(
          options: MapOptions(zoom: 4, minZoom: 4),
          mapController: _controller,
          layers: [
            TileLayerOptions(
              tileProvider: NonCachingNetworkTileProvider(),
              urlTemplate: "https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}@2x.png/?access_token=pk.eyJ1Ijoibml6d2FyIiwiYSI6ImNqbzJpMG1vNzBta3Qza210bjU3eG1lMGUifQ.28m4gM6M7inknP_vQjFEuA",
              additionalOptions: {
                'accessToken': 'pk.eyJ1Ijoibml6d2FyIiwiYSI6ImNqbzJpMG1vNzBta3Qza210bjU3eG1lMGUifQ.28m4gM6M7inknP_vQjFEuA',
                'id': 'mapbox.streets',
              },
            ),
            MarkerLayerOptions(
                markers: _listCorona
                    .map(
                      (e) => Marker(
                        width: 30,
                        height: 30,
                        point: LatLng(e.attributes.lat, e.attributes.long),
                        builder: (context) => Transform(
                          transform: Matrix4.translationValues(0, -12, 0),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(e.attributes.countryRegion),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: <Widget>[
                                          Text("Positif : ${e.attributes.confirmed}"),
                                          Text("Sembuh : ${e.attributes.recovered}"),
                                          Text("Meninggal : ${e.attributes.deaths}"),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Tutup"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              child: Icon(
                                Icons.place,
                                size: 24,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList()),
          ],
        ),
        Container(
          height: 84,
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(child: _positifCoronaWidget()),
              RowDivider(),
              Expanded(child: _sembuhCoronaWidget()),
              RowDivider(),
              Expanded(child: _meninggalCoronaWidget()),
            ],
          ),
        ),
      ],
    );
  }

  Widget _positifCoronaWidget() {
    return FutureBuilder<ValueApi>(
      future: KawalCoronaHttp().getPositif(),
      builder: (BuildContext context, AsyncSnapshot<ValueApi> snapshot) {
        if (snapshot.hasData)
          return InfoCard(
            title: "Positif Corona",
            value: snapshot.data.value,
            color: Colors.redAccent,
          );
        else
          return _loadingCard(context);
      },
    );
  }

  Widget _sembuhCoronaWidget() {
    return FutureBuilder<ValueApi>(
      future: KawalCoronaHttp().getSembuh(),
      builder: (BuildContext context, AsyncSnapshot<ValueApi> snapshot) {
        if (snapshot.hasData)
          return InfoCard(
            title: "Sembuh",
            value: snapshot.data.value,
            color: Colors.lightGreen,
          );
        else
          return _loadingCard(context);
      },
    );
  }

  Widget _meninggalCoronaWidget() {
    return FutureBuilder<ValueApi>(
      future: KawalCoronaHttp().getMeninggal(),
      builder: (BuildContext context, AsyncSnapshot<ValueApi> snapshot) {
        if (snapshot.hasData)
          return InfoCard(
            title: "Meninggal",
            value: snapshot.data.value,
            color: Colors.deepPurple,
          );
        else
          return _loadingCard(context);
      },
    );
  }

  Widget _loadingCard(context) {
    return CustomCard(
      padding: EdgeInsets.all(10),
      child: LoadingFlipping.circle(
        size: 30,
        borderSize: 3,
        borderColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
