import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_login/service.dart';
import 'package:flutter_login/EditPlayerPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_login/profile_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_login/main.dart';


class PlayerListPage extends StatefulWidget {
  const PlayerListPage({Key? key}) : super(key: key);

  @override
  _PlayerListPageState createState() => _PlayerListPageState();
}

class _PlayerListPageState extends State<PlayerListPage> {
  late List<DocumentSnapshot> players;

  @override
  void initState() {
    super.initState();
    // Charger la liste des joueurs au moment de l'initialisation
    loadPlayers();
  }

  Future<void> loadPlayers() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("players").get();
    setState(() {
      players = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des Joueurs"),
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Déconnexion"),
                    content: Text("Êtes-vous sûr de vouloir vous déconnecter?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Annuler"),
                      ),
                      TextButton(
                        onPressed: () {
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
      body: players != null
          ? 
          ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                return 
                ListTile(
  title: Text(players[index]["name"] ?? ""),
 subtitle: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text(players[index]["club"] ?? ""),
    Text(players[index]["salary"] ?? ""),
    Text(players[index]["number"] ?? ""),
  ],
),

  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          // Naviguer vers la page de mise à jour avec l'ID du joueur
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditPlayerPage(
                playerId: players[index].id,
              ),
            ),
          );
        },
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await Service().DeletePlayer(players[index].id);
          // Rafraîchir la liste après la suppression
          loadPlayers();
          Fluttertoast.showToast(
            msg: "Joueur supprimé avec succès!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        },
      ),
    ],
  ),
);
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}