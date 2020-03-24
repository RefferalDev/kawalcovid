import 'package:flutter/material.dart';
import 'package:kawal_corona/components/customCard.dart';
import 'package:kawal_corona/components/customDivider.dart';
import 'package:kawal_corona/components/infoCard.dart';
import 'package:kawal_corona/connection/kawalCoronaHttp.dart';
import 'package:kawal_corona/model/indonesiaModel.dart';
import 'package:kawal_corona/model/provinceApiModel.dart';
import 'package:loading_animations/loading_animations.dart';

class ProvinsiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProvinceApi>>(
      future: KawalCoronaHttp().getStatusProvinsi(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Container(
              height: 300,
              alignment: Alignment.center,
              child: LoadingFlipping.circle(
                borderColor: Theme.of(context).primaryColor,
              ),
            );
            break;
          case ConnectionState.done:
            return ListView.builder(
              padding: EdgeInsets.only(),
              itemCount: snapshot.data.length + 1,
              itemBuilder: (contex, index) {
                if (index == 0) {
                  return FutureBuilder<Indonesia>(
                    future: KawalCoronaHttp().getStatusIndonesia(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          height: 84,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: InfoCard(
                                  title: "Positif",
                                  value: snapshot.data.positif,
                                  color: Colors.red,
                                ),
                              ),
                              RowDivider(),
                              Expanded(
                                child: InfoCard(
                                  title: "Sembuh",
                                  value: snapshot.data.sembuh,
                                  color: Colors.lightGreen,
                                ),
                              ),
                              RowDivider(),
                              Expanded(
                                child: InfoCard(
                                  title: "Meninggal",
                                  value: snapshot.data.meninggal,
                                  color: Colors.purple,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
                snapshot.data.sort((old, newItem) => old.attributes.provinsi.compareTo(newItem.attributes.provinsi));
                var e = snapshot.data[index - 1];
                return _ProvinsiExpansionItemWidget(e: e);
              },
            );
            break;
          default:
            return Container(
              alignment: Alignment.center,
              height: 300,
              child: Text(
                "Gagal memuat data",
                textAlign: TextAlign.center,
              ),
            );
        }
      },
    );
  }
}

class _ProvinsiExpansionItemWidget extends StatelessWidget {
  const _ProvinsiExpansionItemWidget({
    Key key,
    @required this.e,
  }) : super(key: key);

  final ProvinceApi e;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: CustomCard(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: ExpansionTile(
          title: Text(
            "${e.attributes.provinsi} (${e.attributes.kasusPosi})",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: InfoCard(
                      title: "Positif",
                      value: e.attributes.kasusPosi,
                      color: Colors.red,
                    ),
                  ),
                  RowDivider(),
                  Expanded(
                    child: InfoCard(
                      title: "Sembuh",
                      value: e.attributes.kasusSemb,
                      color: Colors.green,
                    ),
                  ),
                  RowDivider(),
                  Expanded(
                    child: InfoCard(
                      title: "Meninggal",
                      value: e.attributes.kasusMeni,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
