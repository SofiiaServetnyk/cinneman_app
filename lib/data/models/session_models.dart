enum SeatType {
  NORMAL,
  BETTER,
  VIP,
}

class MovieSession {
  int id;
  DateTime date;
  String type;
  int minPrice;
  Room room;

  MovieSession({
    required this.id,
    required this.date,
    required this.type,
    required this.minPrice,
    required this.room,
  });

  factory MovieSession.fromJson(Map<String, dynamic> json) => MovieSession(
        id: json['id'],
        date: DateTime.fromMillisecondsSinceEpoch(json['date'] * 1000),
        type: json['type'],
        minPrice: json['minPrice'],
        room: Room.fromJson(json['room']),
      );
}

class Room {
  int id;
  String name;
  List<Row> rows;

  Room({
    required this.id,
    required this.name,
    required this.rows,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json['id'],
        name: json['name'],
        rows: (json['rows'] as List).map((row) => Row.fromJson(row)).toList(),
      );
}

class Row {
  int id;
  int index;
  List<Seat> seats;

  Row({
    required this.id,
    required this.index,
    required this.seats,
  });

  factory Row.fromJson(Map<String, dynamic> json) => Row(
        id: json['id'],
        index: json['index'],
        seats:
            (json['seats'] as List).map((seat) => Seat.fromJson(seat)).toList(),
      );
}

class Seat {
  int id;
  int index;
  SeatType type;
  int price;
  bool isAvailable;

  Seat({
    required this.id,
    required this.index,
    required this.type,
    required this.price,
    required this.isAvailable,
  });

  factory Seat.fromJson(Map<String, dynamic> json) => Seat(
        id: json['id'],
        index: json['index'],
        type: SeatType.values[json['type']],
        price: json['price'],
        isAvailable: json['isAvailable'],
      );
}
