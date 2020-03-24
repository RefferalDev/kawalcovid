import 'package:flutter/material.dart';
import 'package:kawal_corona/components/customDivider.dart';
import 'package:kawal_corona/page/indonesiaHoaxesPage.dart';
import 'package:kawal_corona/page/kasusDuniaPage.dart';
import 'package:kawal_corona/page/provinsiPage.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  final List<TabPage> _listTab = [
    TabPage(
      page: KasusDuniaPage(),
      tab: Tab(
        text: "Kasus Dunia",
      ),
    ),
    TabPage(
      page: ProvinsiPage(),
      tab: Tab(
        text: "Kasus Indonesia",
      ),
    ),
    TabPage(
      page: IndonesiaHoaxesPage(),
      tab: Tab(
        text: "Indonesia Hoaxes",
      ),
    ),
  ];

  TabController tabController;

  bool _scrolled = false;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: _listTab.length);
    tabController.addListener(() {
      if (tabController.index == 0) {
        setState(() {
          _scrolled = false;
        });
      } else {
        setState(() {
          _scrolled = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !_scrolled
        ? Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Image.asset(
                "assets/images/Icon-512.png",
                width: 40,
              ),
              elevation: 0,
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "❤ Nizwar",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    launch("https://fb.me/hangpuan");
                  },
                ),
              ],
              bottom: PreferredSize(
                child: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  indicatorColor: Colors.white,
                  tabs: _listTab.map((e) => e.tab).toList(),
                ),
                preferredSize: Size(MediaQuery.of(context).size.width, 48),
              ),
            ),
            body: TabBarView(
              controller: tabController,
              children: _listTab.map((e) => e.page).toList(),
              physics: _scrolled ?? false ? null : NeverScrollableScrollPhysics(),
            ),
          )
        : Scaffold(
            body: NestedScrollView(
              body: TabBarView(
                controller: tabController,
                children: _listTab.map((e) => e.page).toList(),
                physics: _scrolled ?? false ? null : NeverScrollableScrollPhysics(),
              ),
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    snap: true,
                    title: SizedBox(
                      height: 30,
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            "assets/images/Icon-512.png",
                            width: 30,
                          ),
                          RowDivider(),
                          Text("Kawal Corona"),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          "❤ Nizwar",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          launch("https://fb.me/hangpuan");
                        },
                      ),
                    ],
                    elevation: 0,
                    bottom: PreferredSize(
                      child: TabBar(
                        controller: tabController,
                        isScrollable: true,
                        indicatorColor: Colors.white,
                        tabs: _listTab.map((e) => e.tab).toList(),
                      ),
                      preferredSize: Size(MediaQuery.of(context).size.width, 48),
                    ),
                  )
                ];
              },
            ),
          );
  }
}

class TabPage {
  final Widget page;
  final Tab tab;

  TabPage({this.page, this.tab});
}
