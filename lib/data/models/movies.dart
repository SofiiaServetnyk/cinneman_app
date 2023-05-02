import 'dart:convert';

Movies moviesFromJson(String str) => Movies.fromJson(json.decode(str));

String moviesToJson(Movies data) => json.encode(data.toJson());

class Movies {
  bool success;
  List<Datum> data;

  Movies({
    required this.success,
    required this.data,
  });

  factory Movies.fromJson(Map<String, dynamic> json) => Movies(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String name;
  int age;
  String trailer;
  String image;
  String smallImage;
  String originalName;
  int duration;
  String language;
  String rating;
  int year;
  String country;
  String genre;
  String plot;
  String starring;
  String director;
  String screenwriter;
  String studio;

  Datum({
    required this.id,
    required this.name,
    required this.age,
    required this.trailer,
    required this.image,
    required this.smallImage,
    required this.originalName,
    required this.duration,
    required this.language,
    required this.rating,
    required this.year,
    required this.country,
    required this.genre,
    required this.plot,
    required this.starring,
    required this.director,
    required this.screenwriter,
    required this.studio,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        age: json["age"],
        trailer: json["trailer"],
        image: json["image"],
        smallImage: json["smallImage"],
        originalName: json["originalName"],
        duration: json["duration"],
        language: json["language"],
        rating: json["rating"],
        year: json["year"],
        country: json["country"],
        genre: json["genre"],
        plot: json["plot"],
        starring: json["starring"],
        director: json["director"],
        screenwriter: json["screenwriter"],
        studio: json["studio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "age": age,
        "trailer": trailer,
        "image": image,
        "smallImage": smallImage,
        "originalName": originalName,
        "duration": duration,
        "language": language,
        "rating": rating,
        "year": year,
        "country": country,
        "genre": genre,
        "plot": plot,
        "starring": starring,
        "director": director,
        "screenwriter": screenwriter,
        "studio": studio,
      };
}
