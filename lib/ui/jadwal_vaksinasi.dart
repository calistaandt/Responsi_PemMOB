import 'package:flutter/material.dart';
import 'package:manajemenkesehatan/bloc/logout_bloc.dart';
import 'package:manajemenkesehatan/ui/login_page.dart';
import 'package:manajemenkesehatan/model/jadwal_vaksinasi.dart';
import 'package:manajemenkesehatan/bloc/JadwalVaksinasiBloc.dart'; 
import 'package:manajemenkesehatan/ui/vaksinasi_form.dart';
import 'package:manajemenkesehatan/ui/pasien_page.dart';
import 'package:manajemenkesehatan/ui/nutrisi_page.dart';

class JadwalVaksinasiPage extends StatefulWidget {
  const JadwalVaksinasiPage({Key? key}) : super(key: key);

  @override
  _JadwalVaksinasiPageState createState() => _JadwalVaksinasiPageState();
}

class _JadwalVaksinasiPageState extends State<JadwalVaksinasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Jadwal Vaksinasi',
          style: TextStyle(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const JadwalVaksinasiForm()),
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
                style: TextStyle(fontSize: 18),
              ),
              trailing: const Icon(Icons.logout, color: Color.fromARGB(255, 7, 230, 92)),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  ),
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
            child: FutureBuilder<List<JadwalVaksinasi>>(
              future: JadwalVaksinasiBloc.getJadwalVaksinasi(), 
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Tidak ada data vaksinasi'));
                } else {
                  return ListJadwalVaksinasi(list: snapshot.data!);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ListJadwalVaksinasi extends StatelessWidget {
  final List<JadwalVaksinasi> list;
  const ListJadwalVaksinasi({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, i) {
        return ItemJadwalVaksinasi(jadwalVaksinasi: list[i]);
      },
    );
  }
}

class ItemJadwalVaksinasi extends StatelessWidget {
  final JadwalVaksinasi jadwalVaksinasi;
  const ItemJadwalVaksinasi({Key? key, required this.jadwalVaksinasi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          title: Text(
            jadwalVaksinasi.patientName ?? 'Tidak ada nama',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          subtitle: Text(
            jadwalVaksinasi.vaccineType ?? 'Tidak ada jenis vaksin',
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
