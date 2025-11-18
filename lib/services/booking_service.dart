import 'package:rentapp/data/models/booking.dart';
import 'package:rentapp/data/models/car.dart';

class BookingService {
  static final List<Booking> _bookings = [];

  static List<Booking> getAllBookings() => _bookings;

  static String bookCar(Car car, DateTime startDate, DateTime endDate) {
    final days = endDate.difference(startDate).inDays;
    final totalPrice = car.pricePerHour * 24 * days;
    
    final booking = Booking(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      carModel: car.model,
      startDate: startDate,
      endDate: endDate,
      totalPrice: totalPrice,
      status: 'Confirmed',
    );
    
    _bookings.add(booking);
    return booking.id;
  }
}