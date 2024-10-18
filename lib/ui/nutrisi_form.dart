import 'package:flutter/material.dart';
import 'package:manajemenkesehatan/bloc/NutrisiBloc.dart'; // Assuming you have a similar Bloc for Nutrisi
import 'package:manajemenkesehatan/model/nutrisi.dart';
import 'package:manajemenkesehatan/ui/nutrisi_page.dart';
import 'package:manajemenkesehatan/widget/warning_dialog.dart';

class NutrisiForm extends StatefulWidget {
  final Nutrisi? nutrisi;
  const NutrisiForm({Key? key, this.nutrisi}) : super(key: key);

  @override
  _NutrisiFormState createState() => _NutrisiFormState();
}

class _NutrisiFormState extends State<NutrisiForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH NUTRISI";
  String tombolSubmit = "SIMPAN";

  final _foodItemController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _fatContentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  void isUpdate() {
    if (widget.nutrisi != null) {
      setState(() {
        judul = "UBAH NUTRISI";
        tombolSubmit = "UBAH";
        _foodItemController.text = widget.nutrisi!.foodItem;
        _caloriesController.text = widget.nutrisi!.calories.toString();
        _fatContentController.text = widget.nutrisi!.fatContent.toString();
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
                _foodItemTextField(),
                const SizedBox(height: 16),
                _caloriesTextField(),
                const SizedBox(height: 16),
                _fatContentTextField(),
                const SizedBox(height: 30),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _foodItemTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Nama Makanan",
        border: const OutlineInputBorder(),
        labelStyle: TextStyle(color: Colors.black),
      ),
      controller: _foodItemController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Nama Makanan harus diisi";
        }
        return null;
      },
    );
  }

  Widget _caloriesTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Kalori",
        border: const OutlineInputBorder(),
        labelStyle: TextStyle(color: Colors.black),
      ),
      keyboardType: TextInputType.number,
      controller: _caloriesController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Kalori harus diisi";
        }
        if (int.tryParse(value) == null || int.parse(value) < 0) {
          return "Kalori harus berupa angka positif";
        }
        return null;
      },
    );
  }

  Widget _fatContentTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Konten Lemak (gram)",
        border: const OutlineInputBorder(),
        labelStyle: TextStyle(color: Colors.black),
      ),
      keyboardType: TextInputType.number,
      controller: _fatContentController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Konten Lemak harus diisi";
        }
        if (double.tryParse(value) == null || double.parse(value) < 0) {
          return "Konten Lemak harus berupa angka positif";
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
        backgroundColor: Color.fromARGB(255, 7, 230, 92), // Warna tombol
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
            if (widget.nutrisi != null) {
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

    Nutrisi newNutrisi = Nutrisi(
      id: null,
      foodItem: _foodItemController.text,
      calories: int.parse(_caloriesController.text),
      fatContent: double.parse(_fatContentController.text),
    );

    NutrisiBloc.addNutrisi(nutrisi: newNutrisi).then(
      (value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const NutrisiPage(),
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

    Nutrisi updatedNutrisi = Nutrisi(
      id: widget.nutrisi!.id,
      foodItem: _foodItemController.text,
      calories: int.parse(_caloriesController.text),
      fatContent: double.parse(_fatContentController.text),
    );

    NutrisiBloc.updateNutrisi(nutrisi: updatedNutrisi).then(
      (value) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (BuildContext context) => const NutrisiPage(),
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
