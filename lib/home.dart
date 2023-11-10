import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_app/main.dart';
import 'package:todolist_app/models/task.dart';
import 'package:todolist_app/tasks.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userTheme = Provider.of<UserTheme>(context);
    // Accès au modèle de données

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: userTheme.backgroundColor,
          child: Center(
            child: Column(
              children: [
                Text(
                  userTheme.count.toString(),
                  style: TextStyle(color: Color.fromARGB(255, 62, 126, 153), fontSize: 24),
                ),
                ElevatedButton(
                  onPressed: () {
                    userTheme.incrementCount(); // Appel de la méthode pour incrémenter le compteur
                  },
                  child: Text('Increment'),
                ),
                ElevatedButton(
                  onPressed: () {
                    userTheme.changeBackgroundColor(Color.fromARGB(255, 50, 69, 216)); // Appel de la méthode pour changer la couleur de l'arrière-plan
                  },
                  child: Text('Change Color'),
                ),
                SizedBox(height: 30,),
ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Tasks()),
                      );
                    ; // Appel de la méthode pour incrémenter le compteur
                  },
                  child: Text('afficher les taches'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
