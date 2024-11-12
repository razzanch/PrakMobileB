// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'dart:convert';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));

String articleToJson(Article data) => json.encode(data.toJson());

class Article {
    Status status;
    List<ArticleElement> articles;

    Article({
        required this.status,
        required this.articles,
    });

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        status: Status.fromJson(json["status"]),
        articles: List<ArticleElement>.from(json["articles"].map((x) => ArticleElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
    };
}

class ArticleElement {
    int id;
    String author;
    String title;
    String description;
    String url;
    String urlToImage;
    DateTime publishedAt;
    String content;

    ArticleElement({
        required this.id,
        required this.author,
        required this.title,
        required this.description,
        required this.url,
        required this.urlToImage,
        required this.publishedAt,
        required this.content,
    });

    factory ArticleElement.fromJson(Map<String, dynamic> json) => ArticleElement(
        id: json["id"],
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
    };
}

class Status {
    String status;

    Status({
        required this.status,
    });

    factory Status.fromJson(Map<String, dynamic> json) => Status(
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
    };
}
