import 'package:cinneman/core/style/images.dart';

class FakeMovies {
  String name;
  String image;
  int duration;
  int age;
  String genre;
  String? description;

  FakeMovies(
      {required this.image,
      required this.age,
      required this.duration,
      required this.genre,
      required this.name,
      this.description});

  get length => null;
}

class FakeUtils {
  static List<FakeMovies> getFakeMovies() {
    return [
      FakeMovies(
          image: PngIcons.helperPoster,
          age: 12,
          duration: 120,
          genre: 'пригоди, фантастика, екшн, action',
          name: 'Підземелля і дракони: Честь злодіїв',
          description: 'testbest'),
      FakeMovies(
          image: PngIcons.helperPoster,
          duration: 120,
          age: 18,
          genre: 'drama',
          name: 'Draaamaa',
          description: 'testbest'),
      FakeMovies(
          image: PngIcons.helperPoster,
          duration: 60,
          age: 0,
          genre: 'childer',
          name: 'Ha-ha moment and some other ha-ha moments',
          description: 'testbest'),
    ];
  }
}
