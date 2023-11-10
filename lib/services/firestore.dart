import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirestoreService {
  final CollectionReference tasks =
      FirebaseFirestore.instance.collection('tasks');

  Future<void> addTask(Task task) {
    return FirebaseFirestore.instance.collection('tasks').add(
      {
        'id': task.id,
        'taskTitle': task.title.toString(),
        'taskDesc': task.description.toString(),
        'taskDate': task.date.toString(),
        'taskCategory': task.category.toString(),
        'isChecked': false,
      },
    );
  }

  Future<void> deleteTaskByTitle(String taskTitle) async {
    QuerySnapshot querySnapshot =
        await tasks.where('taskTitle', isEqualTo: taskTitle).get();
    querySnapshot.docs.forEach((doc) {
      doc.reference.delete();
    });
  }

  Future<void> updateTask(Task task )  async {
  // Get a QuerySnapshot of all Task documents where the task ID equals the UUID.
  QuerySnapshot taskQuerySnapshot = await FirebaseFirestore.instance
      .collection('tasks')
      .where('id', isEqualTo: task.id)
      .get();

  // Update each Task document in the QuerySnapshot.
  for (DocumentSnapshot taskDocumentSnapshot in taskQuerySnapshot.docs) {
    await taskDocumentSnapshot.reference.update({
      'isChecked': task.isChecked,
    });
  }
}

  Stream<QuerySnapshot> getTasks() {
    final taskStream = tasks.snapshots();
    return taskStream;
  }

  
}