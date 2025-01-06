import 'package:flutter/material.dart';
import 'package:guin/BoatDetails/Model/nav_details.dart';

class DetailsPage extends StatelessWidget {
  final Stream<List<NavBoatDetailsModel>> boatDataStream;

  DetailsPage({required this.boatDataStream});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Boat Details')),
      body: StreamBuilder<List<NavBoatDetailsModel>>(
        stream: boatDataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Data Available detailspage'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final boat = snapshot.data![index];
                return ListTile(
                  title: Text('Boat: ${boat.bBox1?.timestamp ?? "Unknown"}'),
                  subtitle: Text(
                    'Latitude: ${boat.bBox1?.latitude ?? "N/A"}, Longitude: ${boat.bBox1?.longitude ?? "N/A"}',
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
