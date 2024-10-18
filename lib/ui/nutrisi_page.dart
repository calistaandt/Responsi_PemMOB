import 'package:flutter/material.dart';
import 'package:manajemenkesehatan/model/nutrisi.dart';
import 'package:manajemenkesehatan/ui/login_page.dart';
import 'package:manajemenkesehatan/bloc/logout_bloc.dart';
import 'package:manajemenkesehatan/ui/nutrisi_form.dart'; 
import 'package:manajemenkesehatan/bloc/NutrisiBloc.dart'; 
import 'package:manajemenkesehatan/ui/nutrisi_detail.dart'; 

class NutrisiPage extends StatefulWidget {
  const NutrisiPage({Key? key}) : super(key: key);

  @override
  _NutrisiPageState createState() => _NutrisiPageState();
}

class _NutrisiPageState extends State<NutrisiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Nutrisi',
          style: TextStyle(
            fontFamily: 'SansSerif',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 230, 92),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0, color: Colors.white),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NutrisiForm()),
                );
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'SansSerif',
                ),
              ),
              trailing: const Icon(Icons.logout, color: Color.fromARGB(255, 7, 230, 92)),
              onTap: () async {
                await LogoutBloc.logout().then((value) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                });
              },
            ),
            
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 253, 240, 117),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Expanded(
            child: FutureBuilder<List<Nutrisi>>(
              future: NutrisiBloc.getNutrisi(), 
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return snapshot.hasData
                    ? ListNutrisi(list: snapshot.data)
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ListNutrisi extends StatelessWidget {
  final List<Nutrisi>? list;

  const ListNutrisi({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list?.length ?? 0,
      itemBuilder: (context, i) {
        return ItemNutrisi(
          nutrisi: list![i],
        );
      },
    );
  }
}

class ItemNutrisi extends StatelessWidget {
  final Nutrisi nutrisi;

  const ItemNutrisi({Key? key, required this.nutrisi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NutrisiDetail(nutrisi: nutrisi), 
          ),
        );
      },
      child: Card(
        color: const Color.fromARGB(255, 252, 255, 180),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          title: Text(
            nutrisi.foodItem,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          subtitle: Text(
            'Kalori: ${nutrisi.calories}, Lemak: ${nutrisi.fatContent} gram',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Color.fromARGB(255, 7, 230, 92),
            size: 20,
          ),
        ),
      ),
    );
  }
}
