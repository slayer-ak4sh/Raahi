import 'package:flutter/material.dart';
import 'package:rentapp/data/models/car.dart';
import 'package:rentapp/presentation/widgets/car_card.dart';
import 'package:rentapp/presentation/pages/my_bookings_page.dart';
import 'package:rentapp/presentation/pages/google_maps_page.dart';

class CarListScreen extends StatelessWidget {
  const CarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cars = [
      Car(model: 'Tesla Model S', distance: 870, fuelCapacity: 85, pricePerHour: 45),
      Car(model: 'BMW i8', distance: 520, fuelCapacity: 42, pricePerHour: 38),
      Car(model: 'Audi e-tron', distance: 400, fuelCapacity: 95, pricePerHour: 42),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Car'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Text(
                'Rent App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.car_rental),
              title: const Text('Available Cars'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('My Bookings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyBookingsPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Map View'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GoogleMapsPage(
                    car: cars.first,
                  )),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index){
          return CarCard(car: cars[index]);
        },
      ),
    );
  }
}
