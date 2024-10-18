import 'package:flutter/material.dart';
import 'package:manajemenkesehatan/bloc/JadwalVaksinasiBloc.dart';
import 'package:manajemenkesehatan/model/jadwal_vaksinasi.dart';

class JadwalVaksinasiForm extends StatefulWidget {
  final JadwalVaksinasi? jadwal;

  const JadwalVaksinasiForm({super.key, this.jadwal});

  @override
  _JadwalVaksinasiFormState createState() => _JadwalVaksinasiFormState();
}

class _JadwalVaksinasiFormState extends State<JadwalVaksinasiForm> {
  final _formKey = GlobalKey<FormState>();
  late String patientName;
  late String vaccineType;
  late int age; 

  @override
  void initState() {
    super.initState();
    if (widget.jadwal != null) {
      patientName = widget.jadwal!.patientName ?? '';
      vaccineType = widget.jadwal!.vaccineType ?? '';
      age = widget.jadwal!.age ?? 0; 
    } else {
      patientName = '';
      vaccineType = '';
      age = 0; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Jadwal Vaksinasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: patientName,
                decoration: const InputDecoration(labelText: 'Nama Pasien'),
                validator: (value) => value == null || value.isEmpty ? 'Nama Pasien tidak boleh kosong' : null,
                onChanged: (value) => patientName = value,
              ),
              TextFormField(
                initialValue: vaccineType,
                decoration: const InputDecoration(labelText: 'Tipe Vaksin'),
                validator: (value) => value == null || value.isEmpty ? 'Tipe Vaksin tidak boleh kosong' : null,
                onChanged: (value) => vaccineType = value,
              ),
              TextFormField(
                initialValue: age.toString(), 
                decoration: const InputDecoration(labelText: 'Usia'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Usia tidak boleh kosong';
                  }
                  
                  if (int.tryParse(value) == null) {
                    return 'Usia harus berupa angka';
                  }
                  return null;
                },
                onChanged: (value) {
                  age = int.tryParse(value) ?? 0; 
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    JadwalVaksinasi jadwalVaksinasi = JadwalVaksinasi(
                      id: widget.jadwal?.id,
                      patientName: patientName,
                      vaccineType: vaccineType,
                      age: age, 
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );

                    if (widget.jadwal != null) {
                      await JadwalVaksinasiBloc.updateJadwalVaksinasi(jadwalVaksinasi);
                    } else {
                      await JadwalVaksinasiBloc.addJadwalVaksinasi(jadwalVaksinasi);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.jadwal != null ? 'Update' : 'Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
