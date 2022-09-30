import 'package:cek_tapak_tangan/src/pages/ambil_foto.dart';
import 'package:cek_tapak_tangan/src/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../widgets/appbar.dart';
import '../widgets/bottombar.dart';
import 'list_ensiklopedia.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final dev = Logger();
  int _indexSelected = 1;
  // late String formatted;

  final List<String> _headerName = [
    'Ensiklopedia ',
    'Halaman Ramalan',
    'Halaman Profil',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: AppBarWidget(
          header: _headerName[_indexSelected],
          autoLeading: false,
        ),
      ),
      body: tabWidget(context),
      bottomNavigationBar: BottomBarWidget(
        indexSelected: _indexSelected,
        onTap: (index) {
          setState(() {
            _indexSelected = index;
          });
        },
      ),
    );
  }

  tabWidget(BuildContext context) {
    switch (_indexSelected) {
      case 0:
        return const ListPage();
      case 1:
        return const AmbilFoto();
      case 2:
        return const ProfilPage();
    }
  }
}
