import 'package:cek_tapak_tangan/src/widgets/bounce_scoller.dart';
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BounceScrollerWidget(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Image.asset(
                    'assets/tapak_tangan1.png',
                    width: 300,
                    height: 300,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "     Ada 4 garis pokok yang terdapat pada telapak tangan kiri. Keempat garis utama itu ialah: A. garis kehidupan, B. Garis nasib , C. garis pikiran , D. garis cinta.\n     Garis kehidupan bukan menunjukkan berapa panjang umur seseorang. Tapi menunjukkan kualitas kehidupan yang dijalani. Menunjukkan berapa banyak vitalitas, kekuatan dan energi yang dimiliki. Memberikan gambaran peristiwa apa yang bakal terjadi dalam hiduo orang tersebut dari kecil hingga dewasa, bahkan sampai usia senja\n     Garis nasib menceritakan bagaimana kisah hidup anda berlangsung. Tapi garis nasib lebih menceritakan bagaimana potensi dan kehidupan sosial anda.\n     Garis pikiran mereflesikan pikiran pemiliknya.Bagaimana kepribadian dan sikap seseorang terhadapa apa yang disukai atau dikerjakan\n     Garis cinta mencerminkan kisah cinta, keberuntungan dalam asmara, bahkan kisah cinta dengan selingkuhan.",
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
