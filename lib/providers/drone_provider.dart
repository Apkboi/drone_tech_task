import 'package:drone_tech_task/helpers/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/drones.dart';

class DroneProvider extends ChangeNotifier {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //An enum value that handles request states
  AddDroneState _addDroneState = AddDroneState.idle;
  FetchDroneState _fetchDroneState = FetchDroneState.idle;

  //Array of fetched drones
  List<Drone> drones = [];

  AddDroneState get addDroneState => _addDroneState;

  Future<void> addDrones(Drone drone) async {
    _addDroneState = AddDroneState.loading;
    notifyListeners();
    try {
      await firestore.collection('drones').add(drone.toJson());
      _addDroneState = AddDroneState.success;
      notifyListeners();
    } on FirebaseException catch (e) {
      _addDroneState = AddDroneState.failure;
      notifyListeners();
    }
  }

  Future<void> fetchDrones() async {
    _fetchDroneState = FetchDroneState.loading;
    //Listens to snapshot Change states and changes provider state and update drone list
    firestore.collection('drones').snapshots().listen((event) {
      drones = event.docs.map((e) => Drone.fromJson(e.data())).toList();
      _fetchDroneState = FetchDroneState.fetched;
      notifyListeners();
    }, onError: (error) {});
  }

  //getter for fetchDroneState
  FetchDroneState get fetchDroneState => _fetchDroneState;
}
