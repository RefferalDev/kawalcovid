import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:kawal_corona/components/customCard.dart';
import 'package:kawal_corona/components/customDivider.dart';
import 'package:kawal_corona/components/customShimmer.dart';
import 'package:kawal_corona/connection/indonesiaHoaxesHttp.dart';
import 'package:kawal_corona/model/hoaxArticleModel.dart';
import 'package:kawal_corona/screens/articleScreen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class IndonesiaHoaxesPage extends StatefulWidget {
  @override
  _IndonesiaHoaxesPageState createState() => _IndonesiaHoaxesPageState();
}

class _IndonesiaHoaxesPageState extends State<IndonesiaHoaxesPage> {
  final RefreshController _refreshController = RefreshController();
  final List<ArticleItem> _hoaxArticleList = [];

  int _page = 1;

  @override
  void initState() {
    _loadData(refresh: true);
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Container();
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: () => _loadData(refresh: true),
      onLoading: () {
        _page++;
        _loadData();
      },
      enablePullUp: true,
      child: ListView(
        // shrinkWrap: true,
        children: _hoaxArticleList.length > 0
            ? _hoaxArticleList.map((item) => HoaxArticleItemWidget(hoaxArticle: item)).toList()
            : List.generate(
                8,
                (index) => HoaxArticleItemWidget(),
              ),
      ),
    );
  }

  void _loadData({bool refresh = false}) async {
    if (refresh) {
      setState(() {
        _refreshController.loadNoData();
        _hoaxArticleList.clear();
        _page = 1;
      });
    }
    var raw = await IndonesiaHoaxesHttp().getHoaxArticle(page: _page);
    if (raw == null) {
      _refreshController.loadNoData();
    } else {
      _hoaxArticleList.addAll(raw);
      _refreshController.resetNoData();
      _refreshController.loadComplete();
    }
    _refreshController.refreshCompleted();
    setState(() {});
  }
}

class HoaxArticleItemWidget extends StatelessWidget {
  final ArticleItem hoaxArticle;

  const HoaxArticleItemWidget({Key key, this.hoaxArticle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return Container();
    HtmlUnescape escape = HtmlUnescape();
    if (hoaxArticle != null) {
      return CustomCard(
        borderRadius: 10,
        margin: EdgeInsets.all(5),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleScreen(
                    link: hoaxArticle.id.toString(),
                    title: escape.convert(hoaxArticle.title.rendered),
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    escape.convert(hoaxArticle.title.rendered),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Html(
                    data: escape.convert(hoaxArticle.excerpt.rendered.replaceAll("=", "")),
                    linkStyle: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else
      return CustomCard(
        borderRadius: 10,
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        child: ShimmerContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ShimmerObject(
                width: 130 + (Random().nextInt(MediaQuery.of(context).size.width.floor() - 80).toDouble() - 130),
                height: 25,
                radius: BorderRadius.circular(5),
              ),
              ColumnDivider(
                space: 3,
              ),
              ShimmerObject(
                width: 150 + (Random().nextInt(MediaQuery.of(context).size.width.floor() - 80).toDouble() - 150),
                height: 40,
                radius: BorderRadius.circular(5),
              ),
            ],
          ),
        ),
      );
  }
}
