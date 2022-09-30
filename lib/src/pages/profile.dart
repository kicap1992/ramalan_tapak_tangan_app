import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../widgets/bounce_scoller.dart';

class ProfilPage extends StatefulWidget {
  const ProfilPage({Key? key}) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  @override
  Widget build(BuildContext context) {
    return BounceScrollerWidget(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.center,
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                // borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                  image: AssetImage('assets/loading.gif'),
                  fit: BoxFit.fitHeight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ThemeInfo.myGrey,
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Image.asset(
                'assets/profile_blank.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                "asdsadsa",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ThemeInfo.negroTexto,
                ),
              ),
            ),
            _DetailParent(),
          ],
        ),
      ],
    );
  }
}

class _DetailParent extends StatelessWidget {
  const _DetailParent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _DetailChild(
          icon: Icons.person_pin,
          title: "217 280 201",
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        )
      ],
    );
  }
}

class _DetailChild extends StatelessWidget {
  const _DetailChild({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: ThemeInfo.myGrey,
                  size: 40,
                ),
                const SizedBox(
                  width: 20,
                ),
                Flexible(
                  child: Text(
                    title,
                    maxLines: 3,
                    // softWrap: false,
                    // overflow: TextOverflow.fade,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: ThemeInfo.myGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}