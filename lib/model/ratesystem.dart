class RatingSystem {
  String rateID;
  double rate;
  String userUID;
  String driverUID;
  String comment;
  DateTime dateRated;
  RatingSystem(
      {required this.rateID,
      required this.userUID,
      required this.driverUID,
      required this.rate,
      required this.dateRated,
      required this.comment});
}
