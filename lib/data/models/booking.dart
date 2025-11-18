class Booking {
  final String id;
  final String carModel;
  final DateTime startDate;
  final DateTime endDate;
  final double totalPrice;
  final String status;

  Booking({
    required this.id,
    required this.carModel,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.status,
  });
}