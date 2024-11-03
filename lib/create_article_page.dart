import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateArticlePage extends StatefulWidget {
  const CreateArticlePage({super.key});

  @override
  _CreateArticlePageState createState() => _CreateArticlePageState();
}

class _CreateArticlePageState extends State<CreateArticlePage> {
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _headerController = TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  File? _profileImage;
  File? _headerImage;
  final List<File> _contentImages = []; // Gambar dinamis untuk konten artikel

  final _formKey = GlobalKey<FormState>(); // Untuk validasi form

  // Fungsi untuk mengambil gambar
  Future<void> _pickImage(ImageSource source, String type) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        if (type == 'profile') {
          _profileImage = File(pickedFile.path);
        } else if (type == 'header') {
          _headerImage = File(pickedFile.path);
        } else if (type == 'content') {
          _contentImages.add(File(pickedFile.path));
        }
      });
    }
  }

  void _submitArticle() async {
    if (_formKey.currentState!.validate()) {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Konfirmasi"),
          content:
              const Text("Apakah Anda sudah menulis artikelnya dengan benar?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("Belum"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text("Sudah"),
            ),
          ],
        ),
      );

      if (confirm == true) {
        // Artikel baru
        final article = {
          'author': _authorController.text,
          'header': _headerController.text,
          'institution': _institutionController.text,
          'title': _titleController.text,
          'content': _contentController.text,
          'profileImage': _profileImage,
          'headerImage': _headerImage,
          'contentImages': _contentImages,
        };

        // Kosongkan field setelah submit
        _authorController.clear();
        _headerController.clear();
        _institutionController.clear();
        _titleController.clear();
        _contentController.clear();
        setState(() {
          _profileImage = null;
          _headerImage = null;
          _contentImages.clear();
        });

        // Arahkan ke halaman artikel_hidroponik.dart dan tampilkan notifikasi
        Navigator.of(context).pop(
            article); // Kembali ke halaman daftar artikel dengan artikel baru

        // Tampilkan alert "Artikel berhasil dibuat!"
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Artikel berhasil dibuat!")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tulis Artikel"),
        backgroundColor: Colors.green[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Input untuk foto profil
                const Text("Foto Profil Penulis:"),
                GestureDetector(
                  onTap: () => _pickImage(ImageSource.gallery, 'profile'),
                  child: _profileImage == null
                      ? const Icon(Icons.add_a_photo,
                          size: 50, color: Colors.grey)
                      : Image.file(_profileImage!, height: 100, width: 100),
                ),
                const SizedBox(height: 20),

                // Input untuk gambar header
                const Text("Gambar Header:"),
                GestureDetector(
                  onTap: () => _pickImage(ImageSource.gallery, 'header'),
                  child: _headerImage == null
                      ? const Icon(Icons.add_a_photo,
                          size: 50, color: Colors.grey)
                      : Image.file(_headerImage!, height: 100, width: 100),
                ),
                const SizedBox(height: 20),

                // Input teks biasa
                TextFormField(
                  controller: _authorController,
                  decoration: const InputDecoration(labelText: 'Nama Penulis'),
                  validator: (value) {
                    return value == null || value.isEmpty
                        ? 'Nama penulis harus diisi'
                        : null;
                  },
                ),
                TextFormField(
                  controller: _headerController,
                  decoration: const InputDecoration(labelText: 'Header'),
                  validator: (value) {
                    return value == null || value.isEmpty
                        ? 'Header harus diisi'
                        : null;
                  },
                ),
                TextFormField(
                  controller: _institutionController,
                  decoration:
                      const InputDecoration(labelText: 'Nama Institusi'),
                  validator: (value) {
                    return value == null || value.isEmpty
                        ? 'Nama institusi harus diisi'
                        : null;
                  },
                ),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Judul Artikel'),
                  validator: (value) {
                    return value == null || value.isEmpty
                        ? 'Judul artikel harus diisi'
                        : null;
                  },
                ),
                TextFormField(
                  controller: _contentController,
                  decoration: const InputDecoration(labelText: 'Isi Artikel'),
                  maxLines: 5,
                  validator: (value) {
                    return value == null || value.isEmpty
                        ? 'Isi artikel harus diisi'
                        : null;
                  },
                ),

                const SizedBox(height: 20),

                // Input untuk menambahkan gambar ke konten artikel
                const Text("Gambar di Konten Artikel:"),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery, 'content'),
                  icon: const Icon(Icons.add_photo_alternate),
                  label: const Text("Tambah Gambar"),
                ),
                Wrap(
                  spacing: 10,
                  children: _contentImages
                      .map((image) => Image.file(image, height: 80, width: 80))
                      .toList(),
                ),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitArticle,
                  child: const Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
