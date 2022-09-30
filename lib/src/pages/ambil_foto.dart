import 'dart:io';
import 'dart:typed_data';

import 'package:cek_tapak_tangan/src/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AmbilFoto extends StatefulWidget {
  const AmbilFoto({Key? key}) : super(key: key);

  @override
  State<AmbilFoto> createState() => _AmbilFotoState();
}

class _AmbilFotoState extends State<AmbilFoto> {
  bool _hasFoto = false; // if has foto
  String? _imgPath; // path to foto
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile; // file to foto
  Uint8List? imagebytes;

  Future<void> onImageButtonPressed() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.camera);
      _imageFile = pickedFile;

      final file = File(_imageFile!.path);
      if (file.existsSync()) {
        final Uint8List bytes = await file.readAsBytes();
        setState(() {
          _imgPath = _imageFile!.path.toString();
          imagebytes = bytes;
          _hasFoto = true;
        });
        // popDialog();
        // _showTambahLaporan();
      }
    } catch (e) {
      // dev.e(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          right: MediaQuery.of(context).size.height * 0.1,
          left: MediaQuery.of(context).size.height * 0.1,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Silakan Ambil Foto Telapak Anda",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeInfo.primary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeInfo.primary,
                ),
                onPressed: () {
                  onImageButtonPressed();
                },
                child: Text(
                  "Gambar Telapak Tangan",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
