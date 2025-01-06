import 'package:flutter/material.dart';
import 'package:guin/AMC/model/amc_boat_model.dart';

class BoatDetailScreen extends StatelessWidget {
  final Boat boat;

  BoatDetailScreen({required this.boat});

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsiveness
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(boat.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ListView(
            children: [
              
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      boat.url,
                      height: 250, 
                      width: 400, 
                      fit: BoxFit.cover, 
                    ),
                  ),
                  const SizedBox(width: 30), 
          
                  
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Text(
                          boat.name,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Company: ${boat.company}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Operating Area: ${boat.operatingArea}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Project No: ${boat.projectNo}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Boat Owner: ${boat.boatOwner}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 16),
          
                        // AMC Dates
                        Row(
                          children: [
                            const Icon(
                              Icons.date_range,
                              color: Colors.blue,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'AMC Start: ${boat.amcStartDate} - AMC End: ${boat.amcEndDate}',
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
          
                        // Warranty Expiry Date
                        Row(
                          children: [
                            const Icon(
                              Icons.security,
                              color: Colors.green,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Warranty Expiry: ${boat.warrantyExpireDate}',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
          
                        // Additional Details
                        Text(
                          'Yard No: ${boat.yardNo}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          'No of Pax: ${boat.noOfPax}',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


