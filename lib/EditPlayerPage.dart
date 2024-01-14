import 'package:flutter/material.dart';
import 'package:flutter_login/service.dart';

class EditPlayerPage extends StatefulWidget {
  final String playerId;

  const EditPlayerPage({Key? key, required this.playerId}) : super(key: key);

  @override
  _EditPlayerPageState createState() => _EditPlayerPageState();
}

class _EditPlayerPageState extends State<EditPlayerPage> {
  late TextEditingController playerNameController;
  late TextEditingController playerClubController;
  late TextEditingController playerNumbercontroller;
  late TextEditingController playerSalarycontroller;

  @override
  void initState() {
    super.initState();
    // Charger les informations du joueur à partir de la base de données
    loadPlayerInfo();
  }

  Future<void> loadPlayerInfo() async {
    var playerInfo = await Service().getPlayerById(widget.playerId);
    if (playerInfo != null) {
      setState(() {
        playerNameController = TextEditingController(text: playerInfo["name"]);
        playerClubController = TextEditingController(text: playerInfo["club"]);
        playerNumbercontroller = TextEditingController(text: playerInfo["number"]);
        playerSalarycontroller = TextEditingController(text: playerInfo["salary"]);
         
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modifier Joueur"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: playerNameController,
              decoration: InputDecoration(labelText: "Nom du Joueur"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: playerClubController,
              decoration: InputDecoration(labelText: "Club du Joueur"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: playerNumbercontroller,
              decoration: InputDecoration(labelText: "Number du Joueur"),
            ),
            SizedBox(height: 20),
            TextField(
              controller: playerSalarycontroller,
              decoration: InputDecoration(labelText: "Satary du Joueur"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Appeler la fonction pour mettre à jour le joueur dans la base de données
                updatePlayer();
              },
              child: Text("Enregistrer"),
            ),
          ],
        ),
      ),
    );
  }

  void updatePlayer() async {
    // Appeler la fonction pour mettre à jour le joueur dans la base de données
    if (playerNameController.text.isNotEmpty && playerClubController.text.isNotEmpty && playerNumbercontroller.text.isNotEmpty && playerSalarycontroller.text.isNotEmpty) {
      await Service().updatePlayer(widget.playerId, {
        "name": playerNameController.text,
        "club": playerClubController.text,
        "number": playerNumbercontroller.text,
        "salary": playerSalarycontroller.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Joueur mis à jour avec succès!"),
        ),
      );

      // Revenir à la page précédente
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Veuillez remplir tous les champs."),
        ),
      );
    }
  }
}
