import 'dart:io';
import 'dart:typed_data';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../config/theme.dart';
import '../services/api_service.dart';

class AmbilFoto extends StatefulWidget {
  const AmbilFoto({Key? key}) : super(key: key);

  @override
  State<AmbilFoto> createState() => _AmbilFotoState();
}

class _AmbilFotoState extends State<AmbilFoto> {
  final dev = Logger();
  // bool _hasFoto = false; // if has foto
  String? _imgPath; // path to foto
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile; // file to foto
  Uint8List? imagebytes;
  String? ramalannya;

  List<String> gender = ['Laki-laki', 'Perempuan'];
  String genderValue = 'Laki-laki';
  List<String> umur = ['Anak-anak', 'Dewasa', 'Lanjut Usia'];
  String umurValue = 'Anak-anak';

  @override
  void initState() {
    super.initState();
    // _picker
  }

  Future<void> onImageButtonPressed() async {
    try {
      // _picker.
      final XFile? pickedFile = await _picker.pickImage(
          source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);
      _imageFile = pickedFile;

      final file = File(_imageFile!.path);
      if (file.existsSync()) {
        final Uint8List bytes = await file.readAsBytes();
        setState(() {
          _imgPath = _imageFile!.path.toString();
          imagebytes = bytes;
          // _hasFoto = true;
        });
      }
      await EasyLoading.show(
        // status: "Periksa Foto",
        status: "Membaca Garis Tangan Dari Telapak Tangan Kiri Anda",
        maskType: EasyLoadingMaskType.black,
      );
      Map? cekFoto = await ApiServices.cekFoto(_imgPath);
      await EasyLoading.dismiss();
      // dev.i(cekFoto);
      if (cekFoto!['status'] == 500) return mySnackBar(cekFoto['message'], 1);
      if (cekFoto['status'] == 404) return mySnackBar(cekFoto['message'], 2);
      // await EasyLoading.show(
      //   status: "Membaca Garis Tangan Dari Telapak Tangan Kiri Anda",
      //   maskType: EasyLoadingMaskType.black,
      // );
      // setState(() {
      //   ramalannya = null;
      // });

      // Map? cekRamalan = await ApiServices.cekRamalan(_imgPath);
      // await EasyLoading.dismiss();
      // // dev.i(cekFoto);
      // if (cekRamalan!['status'] == 500) {
      //   return mySnackBar(cekRamalan['message'], 1);
      // }
      // if (cekRamalan['status'] == 404) {
      //   return mySnackBar(cekRamalan['message'], 2);
      // }
      setState(() {
        ramalannya = cekFoto['message'];
        // ramalannya = cekRamalan['message'];
      });
      await EasyLoading.dismiss();

      dialogBoxRamalan();
      // dev.i("jalankan");
    } catch (e) {
      dev.e(e);
    }
  }

  void mySnackBar(String message, int stat) {
    const title = {
      1: "Error",
      2: "Warning",
    };

    const type = {
      1: AnimatedSnackBarType.error,
      2: AnimatedSnackBarType.warning,
    };

    AnimatedSnackBar.rectangle(
      title[stat]!,
      message,
      type: type[stat]!,
      brightness: Brightness.dark,
    ).show(
      context,
    );
  }

  popDialog() {
    Navigator.of(context, rootNavigator: true).pop('dialog');
  }

  void dialogBoxRamalan() async {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content:
              RamalanAlertDialog(imagebytes: imagebytes, ramalan: ramalannya),
        );
      },
    );
  }

  Future<void> dialogBox() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Info",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    height: 250,
                    width: 200,
                    // color: ThemeInfo.primary,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                      color: ThemeInfo.primary,
                      image: const DecorationImage(
                        image: AssetImage('assets/tapak_tangan.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    // chil
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Silakan ambil foto telapak tangan kiri anda seperti gambar diatas",
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      popDialog();
                      onImageButtonPressed();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeInfo.primary,
                    ),
                    child: const Text("Buka Camera"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
              const Text(
                "Silakan Ambil Foto Telapak Anda",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ThemeInfo.primary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Jenis Kelamin',
                    labelStyle: const TextStyle(
                      color: ThemeInfo.primary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: ThemeInfo.primary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: ThemeInfo.primary,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: ThemeInfo.primary,
                        width: 1,
                      ),
                    ),
                  ),
                  value: genderValue,
                  items: gender.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: ThemeInfo.primary,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (item) {
                    // log(item.toString() + " ini item");
                    setState(() {
                      genderValue = item.toString();
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Umur',
                    labelStyle: const TextStyle(
                      color: ThemeInfo.primary,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: ThemeInfo.primary,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: ThemeInfo.primary,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: const BorderSide(
                        color: ThemeInfo.primary,
                        width: 1,
                      ),
                    ),
                  ),
                  value: umurValue,
                  items: umur.map((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(
                          color: ThemeInfo.primary,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (item) {
                    // log(item.toString() + " ini item");
                    setState(() {
                      umurValue = item.toString();
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeInfo.primary,
                ),
                onPressed: () {
                  // onImageButtonPressed();
                  dialogBox();
                },
                child: const Text(
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

class RamalanAlertDialog extends StatelessWidget {
  const RamalanAlertDialog({
    Key? key,
    Uint8List? imagebytes,
    String? ramalan,
  })  : _imagebytes = imagebytes,
        _ramalan = ramalan,
        super(key: key);

  final Uint8List? _imagebytes;
  final String? _ramalan;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Deskripsi Garis Tangan",
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                height: 250,
                width: 200,
                // color: ThemeInfo.primary,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                  color: ThemeInfo.primary,
                  image: DecorationImage(
                    image: MemoryImage(_imagebytes!),
                    fit: BoxFit.fill,
                  ),
                ),
                // chil
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _ramalan ?? "... Sedang Membaca Garis Tangan Anda ...",
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ThemeInfo.primary,
                ),
                child: const Text("Baca Kembali Garis Tangan"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
