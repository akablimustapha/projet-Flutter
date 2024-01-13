import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/service.dart';
import 'package:flutter_login/profile_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_login/main.dart';

class ReadData extends StatefulWidget {
  const ReadData({Key? key});

  @override
  State<ReadData> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  String? name, club, number, salary, id;

  TextEditingController textcontroller = TextEditingController();

  Future<void> searchUser(String name) async {
    try {
      QuerySnapshot querySnapshot = await Service().getPlayer(name);
      id = querySnapshot.docs[0].id;

      name = "${querySnapshot.docs[0]["name"]}";
      club = "${querySnapshot.docs[0]["club"]}";
      salary = "${querySnapshot.docs[0]["salary"]}";
      number = "${querySnapshot.docs[0]["number"]}";

      setState(() {});
    } catch (error) {
      Fluttertoast.showToast(
        msg: "User Not Found",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text(""),
  backgroundColor: Colors.teal,
  elevation: 0,
  actions: [
    // Bouton de déconnexion dans l'appBar
    IconButton(
      icon: Icon(Icons.exit_to_app),
      onPressed: () {
        // Afficher une boîte de dialogue de confirmation
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Déconnexion"),
              content: Text("Êtes-vous sûr de vouloir vous déconnecter?"),
              actions: [
                // Bouton Annuler
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Fermer la boîte de dialogue
                  },
                  child: Text("Annuler"),
                ),
                // Bouton Déconnexion
                TextButton(
                  onPressed: () {
                    // Action à effectuer lors de la déconnexion
                   Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  
                  builder: (context) => const HomePage(),
                  ),  
                  );
                  },
                  child: Text("Déconnexion"),
                ),
              ],
            );
          },
        );
      },
    ),
  ],
),
      body: SingleChildScrollView(
        child: Column(
          
           crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Text(
                "Write Player Name",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 3.0, horizontal: 20.0),
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: const Color(0xFF008080),
                borderRadius: BorderRadius.circular(22),
              ),
              child: TextField(
                controller: textcontroller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Name',
                  hintStyle: TextStyle(color: Colors.white60),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  searchUser(textcontroller.text);
                },
                child: Container(
                  width: 150,
                   padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                  decoration: BoxDecoration(
                   color:  Colors.teal,
                  borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: const Center(
                    child: Text(
                      "Search",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            if (id != null)
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await searchUser(textcontroller.text);
                    await Service().DeletePlayer(id!);
                    Fluttertoast.showToast(
                      msg: "User Data Deleted Successfully!!!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  },
                  child: Container(
                    width: 150,
                   padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                    decoration: BoxDecoration(
                      color:  Colors.teal,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(
              height: 90.0,
            ),
              ElevatedButton(
              onPressed: () {
                // Action à effectuer lorsqu'on appuie sur le bouton
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.teal,
                onPrimary: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                elevation: 5.0,
              ),
              child: Text(
                "Create",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (name != null)
              Center(
                child: Text(
                  "name :  " + name!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(
              height: 10.0,
            ),
            if (club != null)
              Center(
                child: Text(
                  "club :  " + club!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(
              height: 10.0,
            ),
            if (number != null)
              Center(
                child: Text(
                  "number :  " + number!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            const SizedBox(
              height: 10.0,
            ),
            if (salary != null)
              Center(
                child: Text(
                  "salary :  " + salary!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
