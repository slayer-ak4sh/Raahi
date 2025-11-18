import 'package:flutter/material.dart';
import 'package:rentapp/data/models/car.dart';
import 'package:rentapp/services/booking_service.dart';

class BookingPage extends StatefulWidget {
  final Car car;

  const BookingPage({super.key, required this.car});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Car'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.car.model,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Price: \$${widget.car.pricePerHour}/hour',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            const Text('Select Dates:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        setState(() {
                          startDate = date;
                        });
                      }
                    },
                    child: Text(startDate == null ? 'Start Date' : '${startDate!.day}/${startDate!.month}/${startDate!.year}'),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: startDate ?? DateTime.now(),
                        firstDate: startDate ?? DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (date != null) {
                        setState(() {
                          endDate = date;
                        });
                      }
                    },
                    child: Text(endDate == null ? 'End Date' : '${endDate!.day}/${endDate!.month}/${endDate!.year}'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            if (startDate != null && endDate != null)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      'Total Days: ${endDate!.difference(startDate!).inDays}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Total Price: \$${(widget.car.pricePerHour * 24 * endDate!.difference(startDate!).inDays).toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: startDate != null && endDate != null
                    ? () {
                        final bookingId = BookingService.bookCar(widget.car, startDate!, endDate!);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Booking confirmed! ID: $bookingId')),
                        );
                        Navigator.pop(context);
                      }
                    : null,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                child: const Text('Book Now', style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}