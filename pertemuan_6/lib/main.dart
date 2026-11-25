import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Form',
      home: const FormInputPraktikum(),
    );
  }
}

class FormInputPraktikum extends StatefulWidget {
  const FormInputPraktikum({super.key});

  @override
  State<FormInputPraktikum> createState() => _FormInputPraktikumState();
}

class _FormInputPraktikumState extends State<FormInputPraktikum> {
  final _formKey = GlobalKey<FormState>();
  
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _matkulController = TextEditingController();
  
  String? _keteranganKehadiran;
  final List<String> _opsiKehadiran = ['Hadir', 'Izin', 'Sakit'];

  Future<void> simpanData() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('praktikum').add({
          'nama': _namaController.text,
          'nim': _nimController.text,
          'lokasi': _lokasiController.text,
          'mata_kuliah': _matkulController.text,
          'keterangan_kehadiran': _keteranganKehadiran,
          'timestamp': FieldValue.serverTimestamp(),
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data berhasil disimpan')),
          );
        }

        _namaController.clear();
        _nimController.clear();
        _lokasiController.clear();
        _matkulController.clear();
        setState(() {
          _keteranganKehadiran = null;
        });
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal menyimpan data: $e')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    _lokasiController.dispose();
    _matkulController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Data Praktikum'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Field Nama wajib diisi';
                  return null;
                },
              ),
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(labelText: 'NIM'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Field NIM wajib diisi';
                  return null;
                },
              ),
              TextFormField(
                controller: _lokasiController,
                decoration: const InputDecoration(labelText: 'Lokasi'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Field Lokasi wajib diisi';
                  return null;
                },
              ),
              TextFormField(
                controller: _matkulController,
                decoration: const InputDecoration(labelText: 'Mata Kuliah'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Field Mata Kuliah wajib diisi';
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _keteranganKehadiran,
                decoration: const InputDecoration(labelText: 'Keterangan Kehadiran'),
                items: _opsiKehadiran.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _keteranganKehadiran = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Pilih Keterangan Kehadiran';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: simpanData,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}