import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:trainx_app/features/workouts/data/models/workout_model/workout_model.dart';

const workoutCollection = 'workouts';

abstract class WorkoutsDataSource {
  Future<List<WorkoutModel>> fetchWorkouts({
    String? type,
    String? level,
  });
  Future<WorkoutModel?> fetchWorkoutDetails(String workoutId);
}

@Singleton(as: WorkoutsDataSource)
class FireBaseWorkoutsDataSource implements WorkoutsDataSource {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<List<WorkoutModel>> fetchWorkouts(
      {String? type, String? level}) async {
    Query query = _firestore.collection(workoutCollection);

    if (type != null) {
      query = query.where('type', isEqualTo: type);
    }
    if (level != null) {
      query = query.where('level', isEqualTo: level);
    }

    final workouts = await query.get();
    return workouts.docs
        .map((e) => WorkoutModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<WorkoutModel?> fetchWorkoutDetails(String workoutId) async {
    final doc =
        await _firestore.collection(workoutCollection).doc(workoutId).get();
    final data = doc.data();
    if (data != null) {
      return WorkoutModel.fromJson(data);
    }
    return null;
  }
}
