import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rentapp/data/models/car.dart';
import 'package:rentapp/presentation/pages/booking_page.dart';

class GoogleMapsPage extends StatefulWidget {
  final Car car;

  const GoogleMapsPage({super.key, required this.car});

  @override
  State<GoogleMapsPage> createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  GoogleMapController? mapController;
  LatLng currentLocation = const LatLng(28.6139, 77.2090); // Delhi default
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _addCarMarkers();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.whileInUse || 
          permission == LocationPermission.always) {
        Position position = await Geolocator.getCurrentPosition();
        setState(() {
          currentLocation = LatLng(position.latitude, position.longitude);
        });
        mapController?.animateCamera(
          CameraUpdate.newLatLng(currentLocation),
        );
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void _addCarMarkers() {
    // Add car locations (sample data)
    final carLocations = [
      LatLng(28.6139, 77.2090), // Delhi
      LatLng(28.6200, 77.2100), // Near Delhi
      LatLng(28.6100, 77.2000), // Near Delhi
    ];

    for (int i = 0; i < carLocations.length; i++) {
      markers.add(
        Marker(
          markerId: MarkerId('car_$i'),
          position: carLocations[i],
          infoWindow: InfoWindow(
            title: '${widget.car.model} - ${i + 1}',
            snippet: 'Available for rent',
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.car.model,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },
            initialCameraPosition: CameraPosition(
              target: currentLocation,
              zoom: 14.0,
            ),
            markers: markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/car_image.png',
                            width: 80,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.car.model,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '\$${widget.car.pricePerHour}/hour',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildFeature(Icons.speed, '${widget.car.distance.toInt()} km', 'Range'),
                        _buildFeature(Icons.local_gas_station, '${widget.car.fuelCapacity.toInt()}L', 'Fuel'),
                        _buildFeature(Icons.star, '4.8', 'Rating'),
                      ],
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingPage(car: widget.car),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: const Text(
                          'Book Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.grey[600]),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}