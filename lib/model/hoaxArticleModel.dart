import 'model.dart';

class ArticleItem extends Model {
  int id;
  Guid guid;
  String link;
  Guid title;
  Excerpt excerpt;

  ArticleItem({
    this.id,
    this.guid,
    this.link,
    this.title,
    this.excerpt,
  });

  factory ArticleItem.fromJson(Map<String, dynamic> json) => ArticleItem(
        id: json["id"] == null ? null : json["id"],
        guid: json["guid"] == null ? null : Guid.fromJson(json["guid"]),
        link: json["link"] == null ? null : json["link"],
        title: json["title"] == null ? null : Guid.fromJson(json["title"]),
        excerpt: json["excerpt"] == null ? null : Excerpt.fromJson(json["excerpt"]),
      );

  @override
  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "guid": guid == null ? null : guid.toJson(),
        "link": link == null ? null : link,
        "title": title == null ? null : title.toJson(),
        "excerpt": excerpt == null ? null : excerpt.toJson(),
      };
}

class Excerpt extends Model {
  String rendered;
  bool protected;

  Excerpt({
    this.rendered,
    this.protected,
  });

  factory Excerpt.fromJson(Map<String, dynamic> json) => Excerpt(
        rendered: json["rendered"] == null ? null : json["rendered"],
        protected: json["protected"] == null ? null : json["protected"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "rendered": rendered == null ? null : rendered,
        "protected": protected == null ? null : protected,
      };
}

class Guid extends Model {
  String rendered;

  Guid({
    this.rendered,
  });

  factory Guid.fromJson(Map<String, dynamic> json) => Guid(
        rendered: json["rendered"] == null ? null : json["rendered"],
      );
  @override
  Map<String, dynamic> toJson() => {
        "rendered": rendered == null ? null : rendered,
      };
}
