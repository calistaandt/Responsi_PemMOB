import 'package:flutter/material.dart';
import 'package:manajemenkesehatan/bloc/RekamMedisPasienBloc.dart';
import 'package:manajemenkesehatan/model/rekam_medis_pasien.dart';
import 'package:manajemenkesehatan/ui/pasien_page.dart';
import 'package:manajemenkesehatan/widget/warning_dialog.dart';

class RekamMedisPasienForm extends StatefulWidget {
  final RekamMedisPasien? rekamMedisPasien;
  const RekamMedisPasienForm({Key? key, this.rekamMedisPasien}) : super(key: key);

  @override
  _RekamMedisPasienFormState createState() => _RekamMedisPasienFormState();
}

class _RekamMedisPasienFormState extends State<RekamMedisPasienForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH REKAM MEDIS PASIEN";
  String tombolSubmit = "SIMPAN";

  final _patientNameTextboxController = TextEditingController();
  final _symptomTextboxController = TextEditingController();
  final _severityTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  void isUpdate() {
    if (widget.rekamMedisPasien != null) {
      setState(() {
        judul = "UBAH REKAM MEDIS PASIEN";
        tombolSubmit = "UBAH";
        _patientNameTextboxController.text = widget.rekamMedisPasien!.patientName!;
        _symptomTextboxController.text = widget.rekamMedisPasien!.symptom!;
        _severityTextboxController.text = widget.rekamMedisPasien!.severity.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        backgroundColor: Color.fromARGB(255, 7, 230, 92),
      ),
      backgroundColor: const Color.fromARGB(255, 253, 240, 117),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 50),
                _patientNameTextField(),
                const SizedBox(height: 16),
                _symptomTextField(),
                const SizedBox(height: 16),
                _severityTextField(),
                const SizedBox(height: 30),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _patientNameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nama Pasien",
        border: const OutlineInputBorder(),
        labelStyle: TextStyle(color: Colors.black),
      ),
      controller: _patientNameTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Pasien harus diisi";
        }
        return null;
      },
    );
  }

  Widget _symptomTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Gejala",
        border: const OutlineInputBorder(),
        labelStyle: TextStyle(color: Colors.black),
      ),
      controller: _symptomTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Gejala harus diisi";
        }
        return null;
      },
    );
  }

  Widget _severityTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Tingkat Keparahan (1-5)",
        border: const OutlineInputBorder(),
        labelStyle: TextStyle(color: Colors.black),
      ),
      keyboardType: TextInputType.number,
      controller: _severityTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Tingkat Keparahan harus diisi";
        }
        if (int.tryParse(value) == null || int.parse(value) < 1 || int.parse(value) > 5) {
          return "Tingkat Keparahan harus antara 1 dan 5";
        }
        return null;
      },
    );
  }

  Widget _buttonSubmit() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Color.fromARGB(255, 7, 230, 92), // Warna biru untuk tombol
        foregroundColor: Colors.white, // Teks tombol berwarna putih
      ),
      child: _isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(
              tombolSubmit,
              style: const TextStyle(fontSize: 18),
            ),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          if (!_isLoading) {
            if (widget.rekamMedisPasien != null) {
              ubah();
            } else {
              simpan();
            }
          }
        }
      },
    );
  }

  void simpan() {
    setState(() {
      _isLoading = true;
    });

    RekamMedisPasien newRekamMedisPasien = RekamMedisPasien(
      id: null,
      patientName: _patientNameTextboxController.text,
      symptom: _symptomTextboxController.text,
      severity: int.parse(_severityTextboxController.text),
    );

    RekamMedisPasienBloc.addRekamMedisPasien(rekamMedisPasien: newRekamMedisPasien).then(
      (value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const RekamMedisPasienPage(),
          ),
        );
      },
      onError: (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Simpan gagal, silahkan coba lagi",
          ),
        );
      },
    ).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void ubah() {
    setState(() {
      _isLoading = true;
    });

    RekamMedisPasien updatedRekamMedisPasien = RekamMedisPasien(
      id: widget.rekamMedisPasien!.id,
      patientName: _patientNameTextboxController.text,
      symptom: _symptomTextboxController.text,
      severity: int.parse(_severityTextboxController.text),
    );

    RekamMedisPasienBloc.updateRekamMedisPasien(rekamMedisPasien: updatedRekamMedisPasien).then(
      (value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const RekamMedisPasienPage(),
          ),
        );
      },
      onError: (error) {
        showDialog(
          context: context,
          builder: (BuildContext context) => const WarningDialog(
            description: "Ubah data gagal, silahkan coba lagi",
          ),
        );
      },
    ).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
