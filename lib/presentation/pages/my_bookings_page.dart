import 'package:flutter/material.dart';
import 'package:rentapp/services/booking_service.dart';

class MyBookingsPage extends StatelessWidget {
  const MyBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bookings = BookingService.getAllBookings();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bookings'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: bookings.isEmpty
          ? const Center(
              child: Text(
                'No bookings yet',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                final booking = bookings[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.carModel,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text('Booking ID: ${booking.id}'),
                      const SizedBox(height: 5),
                      Text('From: ${booking.startDate.day}/${booking.startDate.month}/${booking.startDate.year}'),
                      Text('To: ${booking.endDate.day}/${booking.endDate.month}/${booking.endDate.year}'),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total: \$${booking.totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              booking.status,
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}