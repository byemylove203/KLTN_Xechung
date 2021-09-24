class Car {
  String name;
  List<String> imageUrl;
  String price;
  String descripstion;
  String feature;
  String carID;
  String userID;
  String status;
  bool favorite;
  bool newest;
  Car(this.name, this.imageUrl, this.price, this.descripstion, this.feature,
      this.carID, this.userID, this.status, this.favorite, this.newest);
}

// List<Car> getCarList() {
//   return <Car>[
//     Car("Car", ["assets/images/car.jpeg", "assets/images/car_1.jpeg"], true,
//         true),
//     Car("Car", ["assets/images/car_1.jpeg"], true, true),
//     Car("Car", ["assets/images/car_2.jpeg"], true, true),
//     Car("Car", ["assets/images/car_3.jpeg"], true, true),
//   ];
// }
