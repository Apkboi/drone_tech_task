import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/drones.dart';

class DroneItem extends StatelessWidget {
  const DroneItem({Key? key, required this.drone, required this.index}) : super(key: key);
  final Drone drone;
  final String index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.only(right: 16,left: 16,bottom: MediaQuery.of(context).viewInsets.bottom),
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10,),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.indigo.shade50),
                 width: 50,
                 height: 60,
            child: Center(child: Text(index),),
          ),
          const SizedBox(width: 10,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  drone.idTag,
                  style:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5,),
                Text(
                  'Weight :${drone.weightCapacity}',
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 5,),
                Text(
                  'Manufacturer :${drone.manufacturer}',
                  style: const TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
          Text(drone.served ? 'Served':'Not served')
        ],
      ),
    );
  }
}
