import 'package:drone_tech_task/helpers/enums.dart';
import 'package:drone_tech_task/models/drones.dart';
import 'package:drone_tech_task/presenter/widgets/filled_textfield.dart';
import 'package:drone_tech_task/providers/drone_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDroneModal extends StatefulWidget {
  final VoidCallback onSuccess;

  const AddDroneModal({Key? key, required this.onSuccess}) : super(key: key);

  @override
  State<AddDroneModal> createState() => _AddDroneModalState();
}

class _AddDroneModalState extends State<AddDroneModal> {

  //Controllers
  final _tagController = TextEditingController();
  final _weightController = TextEditingController();
  final _manufacturerController = TextEditingController();
  final _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),

        //Form to add drones
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(onPressed: (){
                Navigator.pop(context);
              }, icon: const Icon(Icons.close)),
              const SizedBox(height: 16,),
              const Text(
                'Add Drone',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Enter details about drone to add to list.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(
                height: 16,
              ),
              FilledTextField(
                  hint: 'Drone ID tag',
                  validator: (val) {
                    return validator(val, 'Enter drone id');
                  },
                  controller: _tagController),
              const SizedBox(
                height: 10,
              ),
              FilledTextField(
                  controller: _manufacturerController,
                  hint: 'Drone Manufacturer',
                  validator: (val) {
                    return validator(val, 'Enter Manufacturer');
                  }),
              const SizedBox(
                height: 10,
              ),
              FilledTextField(
                  controller: _weightController,
                  hint: 'Drone Weight Capacity',
                  validator: (val) {
                    return validator(val, 'Enter Weight Capacity');
                  }),
              const SizedBox(
                height: 16,
              ),
              FilledTextField(
                  controller: _dateController,
                  hint: 'Date of acquisition',
                  validator: (val) {
                    return validator(val, 'Enter Date of acquisition');
                  }),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // widget.onSuccess();
                          addDrone(context);
                        },
                        child: Consumer<DroneProvider>(
                            builder: (BuildContext context, value,
                                Widget? child) {
                              if (value.addDroneState == AddDroneState
                                  .loading) {
                                return const Center(
                                  child: SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator()),
                                );
                              } else {
                                return const Text('Save');
                              }
                            },
                            child: const Text('Save')),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                        ),
                      )),
                ],
              )
              // FilledTextField(
              //     controller: _tagController,
              //
              //     hint: 'Enter Drone ID tag',validator:(val){
              //   return validator(val, 'Enter drone id');
              // })
            ],
          ),
        ),
      ),
    );
  }

  // textfield validator
  String? validator(String? value, String errorMessage) {
    if (value!.isEmpty) {
      return errorMessage;
    }
  }

  // function to add drone
  void addDrone(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Provider.of<DroneProvider>(context, listen: false)
          .addDrones(Drone(
          idTag: _tagController.text,
          weightCapacity: _weightController.text,
          manufacturer: _manufacturerController.text,
          served: false,
          dateOfAcquisition: _dateController.text ))
          .then((value) {
        Navigator.pop(context);
      });
    }
  }
}
