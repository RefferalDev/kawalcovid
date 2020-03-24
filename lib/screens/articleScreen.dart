import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kawal_corona/components/customDivider.dart';
import 'package:kawal_corona/connection/indonesiaHoaxesHttp.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleScreen extends StatelessWidget {
  final String link;
  final String title;

  const ArticleScreen({Key key, this.link, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("#TurnBackHoax"),
      ),
      body: FutureBuilder<String>(
        future: IndonesiaHoaxesHttp().getArticle(link),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Text(
                    title ?? "",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ColumnDivider(),
                  Html(
                    data: snapshot.data,
                    onLinkTap: (link) async {
                      if (await canLaunch(link)) launch(link);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Container(
              alignment: Alignment.center,
              child: LoadingFlipping.circle(
                borderColor: Theme.of(context).primaryColor,
              ),
            );
          }
        },
      ),
    );
  }
}
