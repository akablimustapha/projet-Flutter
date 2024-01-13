import 'package:flutter/material.dart';
import 'package:flutter_login/service.dart';
import 'package:flutter_login/read_data.dart';
import 'package:flutter_login/main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_login/PlayerListPage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  uploadData() async {
    Map<String, dynamic> uploaddata = {
      "club": clubnamecontroller.text,
      "name": playernamecontroller.text,
      "number": playernumbercontroller.text,
      "salary": playersalarycontroller.text,
    };

    await Service().addPlayer(uploaddata);
    Fluttertoast.showToast(
      msg: "Data Uploaded Successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  TextEditingController playernamecontroller = TextEditingController();
  TextEditingController clubnamecontroller = TextEditingController();
  TextEditingController playernumbercontroller = TextEditingController();
  TextEditingController playersalarycontroller = TextEditingController();

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

      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Player Name",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: playernamecontroller,
              decoration: InputDecoration(
                hintText: 'Enter Player Name',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Player Club",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: clubnamecontroller,
              decoration: InputDecoration(
                hintText: 'Enter Player Club',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Player Number",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: playernumbercontroller,
              decoration: InputDecoration(
                hintText: 'Enter Player Number',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Player Salary",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: playersalarycontroller,
              decoration: InputDecoration(
                hintText: 'Enter Player Salary',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               ElevatedButton(
  onPressed: () {
    // Action à effectuer lorsqu'on appuie sur le bouton
    uploadData();
  },
  style: ElevatedButton.styleFrom(
    primary: Colors.teal, // Couleur de fond du bouton
    onPrimary: Colors.white, // Couleur du texte du bouton
    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0), // Bord arrondi du bouton
    ),
    elevation: 5.0, // Effet d'élévation du bouton
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

    ElevatedButton(
   onPressed: () {
    // Action à effectuer lorsqu'on appuie sur le bouton
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const ReadData(),
      ),
    );
  },
  style: ElevatedButton.styleFrom(
    primary: Colors.teal, // Couleur de fond du bouton
    onPrimary: Colors.white, // Couleur du texte du bouton
    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25.0), // Bord arrondi du bouton
    ),
    elevation: 5.0, // Effet d'élévation du bouton
  ),
  child: Text(
    "Search",
    style: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
  ),
),
ElevatedButton(
  onPressed: () {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PlayerListPage(),
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
    "Voir la Liste des Joueurs",
    style: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
  ),
),


              ],
            ),
          ],
        ),
      ),
    );
  }
}
