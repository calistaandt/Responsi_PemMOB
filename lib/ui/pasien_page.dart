import 'package:flutter/material.dart';
import 'package:manajemenkesehatan/model/rekam_medis_pasien.dart';
import 'package:manajemenkesehatan/ui/login_page.dart';
import 'package:manajemenkesehatan/bloc/logout_bloc.dart';
import 'package:manajemenkesehatan/ui/pasien_detail.dart';
import 'package:manajemenkesehatan/ui/pasien_form.dart';
import 'package:manajemenkesehatan/ui/jadwal_vaksinasi.dart';
import 'package:manajemenkesehatan/bloc/RekamMedisPasienBloc.dart'; 
import 'package:manajemenkesehatan/ui/nutrisi_page.dart';

class RekamMedisPasienPage extends StatefulWidget {
  const RekamMedisPasienPage({Key? key}) : super(key: key);
  
  @override
  _RekamMedisPasienPageState createState() => _RekamMedisPasienPageState();
}

class _RekamMedisPasienPageState extends State<RekamMedisPasienPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Rekam Medis Pasien',
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
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RekamMedisPasienForm()));
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
                await LogoutBloc.logout().then((value) => {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false)
                });
              },
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const RekamMedisPasienPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Jadwal Vaksinasi'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const JadwalVaksinasiPage()),
                );
              },
            ),
            ListTile(
              title: const Text('Data Nutrisi'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const NutrisiPage()),
                );
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
            child: FutureBuilder<List<RekamMedisPasien>>(
              future: RekamMedisPasienBloc.getRekamMedisPasien(), 
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return snapshot.hasData
                    ? ListRekamMedisPasien(list: snapshot.data) 
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

class ListRekamMedisPasien extends StatelessWidget {
  final List<RekamMedisPasien>? list; 
  const ListRekamMedisPasien({Key? key, this.list}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list?.length ?? 0,
      itemBuilder: (context, i) {
        return ItemRekamMedisPasien(
          rekamMedisPasien: list![i], 
        );
      },
    );
  }
}

class ItemRekamMedisPasien extends StatelessWidget {
  final RekamMedisPasien rekamMedisPasien; 
  const ItemRekamMedisPasien({Key? key, required this.rekamMedisPasien}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RekamMedisPasienDetail(rekamMedisPasien: rekamMedisPasien),
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
            rekamMedisPasien.patientName ?? 'Tidak ada nama', 
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          subtitle: Text(
            rekamMedisPasien.symptom ?? 'Tidak ada gejala', 
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
