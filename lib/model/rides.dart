class Rides {
  String userName;
  String driverUID;
  String imageURL;
  double rates;
  String startLocation;
  String endLocation;
  DateTime startHour;
  List<dynamic> daysOfWeek;
  int price;
  int avaiableSeats;

  String carInfo;
  Rides(this.daysOfWeek, this.startHour,
      {this.userName = "Quốc Khánh",
      this.driverUID = "",
      this.imageURL = "assets/images/user_1.jpeg",
      this.rates = 5,
      this.startLocation = "Số 9 Ngách 6/432, Hoàng Văn Thụ, Thái Nguyên",
      this.endLocation = "Ngõ 282 Nguyễn Huy Tưởng, Thanh Xuân, Hà Nội",
      this.price = 70,
      this.avaiableSeats = 3,
      this.carInfo = "Toyota Camry Đen"});
}
