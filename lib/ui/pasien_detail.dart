import 'package:flutter/material.dart';
import 'package:manajemenkesehatan/model/rekam_medis_pasien.dart';
import 'package:manajemenkesehatan/ui/pasien_page.dart';
import 'package:manajemenkesehatan/ui/pasien_form.dart';
import 'package:manajemenkesehatan/bloc/RekamMedisPasienBloc.dart';
import 'package:manajemenkesehatan/widget/warning_dialog.dart';

class RekamMedisPasienDetail extends StatefulWidget {
  final RekamMedisPasien? rekamMedisPasien;

  const RekamMedisPasienDetail({super.key, this.rekamMedisPasien});

  @override
  _RekamMedisPasienDetailState createState() => _RekamMedisPasienDetailState();
}

class _RekamMedisPasienDetailState extends State<RekamMedisPasienDetail> {
  final Color primaryColor = const Color.fromARGB(255, 7, 230, 92);
  final Color backgroundColor = const Color.fromARGB(255, 253, 240, 117);
  final Color editButtonColor = Colors.blueAccent;
  final Color deleteButtonColor = Colors.redAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Rekam Medis Pasien',
          style: TextStyle(
            fontFamily: 'SansSerif',
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
      ),
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.85,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 8,
                  shadowColor: primaryColor.withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildDetailRow(Icons.badge, "ID Rekam Medis: ${widget.rekamMedisPasien?.id}"),
                        _buildDetailRow(Icons.person, "Nama Pasien: ${widget.rekamMedisPasien?.patientName}"),
                        _buildDetailRow(Icons.sick, "Gejala: ${widget.rekamMedisPasien?.symptom}"),
                        _buildDetailRow(Icons.warning, "Tingkat Keparahan: ${widget.rekamMedisPasien?.severity}"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            _tombolHapusEdit(),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: primaryColor),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'SansSerif',
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: editButtonColor,
            side: const BorderSide(color: Colors.blueAccent, width: 1.5),
          ),
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RekamMedisPasienForm(
                  rekamMedisPasien: widget.rekamMedisPasien!,
                ),
              ),
            );
          },
        ),
        const SizedBox(width: 20),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: deleteButtonColor,
            side: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = AlertDialog(
      content: const Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol Ya
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.redAccent,
            side: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),
          child: const Text("Ya"),
          onPressed: () {
            RekamMedisPasienBloc.deleteRekamMedisPasien(id: int.parse(widget.rekamMedisPasien!.id!)).then(
              (value) => {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const RekamMedisPasienPage(),
                  ),
                )
              },
              onError: (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => const WarningDialog(
                    description: "Hapus gagal, silahkan coba lagi",
                  ),
                );
              },
            );
          },
        ),
        // Tombol Batal
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.grey[300],
          ),
          child: const Text("Batal"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(context: context, builder: (context) => alertDialog);
  }

}
