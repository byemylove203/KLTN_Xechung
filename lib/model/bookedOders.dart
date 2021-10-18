import 'package:xechung/model/status.dart';

class BookedOrders {
  int orderID;
  String clientUserID;
  String clientUID;
  String driverID;
  String driverUID;
  DateTime bookedDate;
  int bookedSeat;

  DateTime bookedHour;
  DateTime pickupHour;
  String pickupLocation;
  String dropLocation;
  int price;

  String paymentMethod;
  String status;
  BookedOrders(
      {required this.orderID,
      required this.clientUserID,
      required this.clientUID,
      required this.driverID,
      required this.driverUID,
      required this.bookedSeat,
      required this.bookedDate,
      required this.bookedHour,
      required this.pickupHour,
      required this.pickupLocation,
      required this.dropLocation,
      required this.price,
      required this.paymentMethod,
      required this.status});
}
