class MyRow {
  List<Seat> getFakeSeats() {
    return [
      Seat(id: 1, index: 1, type: 0, price: 160, isAvailable: true),
      Seat(id: 1, index: 1, type: 0, price: 160, isAvailable: true),
      Seat(id: 1, index: 1, type: 0, price: 160, isAvailable: true),
      Seat(id: 1, index: 1, type: 0, price: 160, isAvailable: true),
      Seat(id: 1, index: 1, type: 0, price: 160, isAvailable: true),
      Seat(id: 1, index: 1, type: 0, price: 160, isAvailable: true),
      Seat(id: 2, index: 2, type: 1, price: 160, isAvailable: true),
      Seat(id: 2, index: 2, type: 1, price: 160, isAvailable: false),
      Seat(id: 2, index: 2, type: 0, price: 160, isAvailable: false),
      Seat(id: 2, index: 2, type: 2, price: 160, isAvailable: true),
    ];
  }

  int getNumberOfSeats() {
    return getFakeSeats().length;
  }
}

class Seat {
  int id;
  int index;
  int type;
  int price;
  bool isAvailable;

  Seat({
    required this.id,
    required this.index,
    required this.type,
    required this.price,
    required this.isAvailable,
  });
}
