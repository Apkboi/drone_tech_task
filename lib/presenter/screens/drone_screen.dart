import 'dart:developer';

import 'package:drone_tech_task/helpers/enums.dart';
import 'package:drone_tech_task/presenter/widgets/add_drone_modal.dart';
import 'package:drone_tech_task/providers/drone_provider.dart';
import 'package:drone_tech_task/presenter/widgets/drone_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DronesScreen extends StatefulWidget {
  const DronesScreen({Key? key}) : super(key: key);

  @override
  State<DronesScreen> createState() => _DronesScreenState();
}

class _DronesScreenState extends State<DronesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<DroneProvider>(context, listen: false).fetchDrones();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              //Shows Dialog to add drones
              await showAddDroneDialog(context);
            },
            child: const Icon(Icons.add)),
        body: Container(
          padding: const EdgeInsets.all(16),
          child: Consumer<DroneProvider>(
            builder: (context, value, child) {
              // Checking for current state before returning a view
              if (value.fetchDroneState == FetchDroneState.fetched) {
                //Checking for drones length
                if (value.drones.isEmpty) {
                  return const Center(
                    child: Text(
                      'Their are no added drones click the floating actionButton to add one.',
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'List Of Drones',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 16,),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.drones.length,
                          itemBuilder: (context, index) => DroneItem(
                              drone: value.drones[index],
                              index: (index + 1).toString()),
                        ),
                      ),
                    ],
                  );
                }
              } else if (value.fetchDroneState == FetchDroneState.failure) {
                return const Center(child: Text('An Error Occurred'));
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }


  // Function to Show the add_drone form
  Future showAddDroneDialog(BuildContext ctx) async {
    await showDialog(
      context: ctx,
      builder: (context) {
        return AddDroneModal(
          onSuccess: () {
            log('success');
            Navigator.pop(ctx);
          },
        );
      },
    );
  }
}
