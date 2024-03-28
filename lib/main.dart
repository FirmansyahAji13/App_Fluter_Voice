import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true, // Center the title text
          backgroundColor: Colors.blue, // Set background color of the appbar
          title: Text(
          'Cerita Rakyat: Keong Mas',
          style: TextStyle(color: Colors.white), // Set text color to white
          )
        ),
        body: KeongMasStory(),
      ),
    );
  }
}

class KeongMasStory extends StatefulWidget {
  @override
  _KeongMasStoryState createState() => _KeongMasStoryState();
}

class _KeongMasStoryState extends State<KeongMasStory> {
  final String _storySummary =
      "Cerita Keong Mas bermula dari kisah kehidupan di Kerajaan Daha, yang dipimpin oleh Raja Kertamarta. Sang Raja memiliki dua putri yang cantik dan baik hati, yaitu Dewi Galuh dan Candra Kirana. Dikisahkan, Candra Kirana telah ditunangkan dengan Raden Inu Kertapati, putra mahkota Kerajaan Kahuripan, yang baik dan bijaksana. Namun, saudari kandung Candra Kirana, Galuh Ajeng, sangat iri kepada Candra Kirana dan menginginkan Raden Inu untuk dirinya sendiri. Galuh Ajeng menghalalkan segala cara demi mendapatkan Raden Inu. Ia pun meminta bantuan nenek sihir agar mengutuk Candra Kirana. Akibatnya, Candra Kirana diusir dari istana. Ketika Candra Kirana berjalan di sepanjang pantai, terlantung-lantung karena terusir dari istana, tiba-tiba nenek sihir muncul dan menjadikannya seekor keong emas. Keong emas jelmaan Candra Kirana kemudian dibuang ke laut. Kutukan yang menimpanya dapat hilang jika keong emas bertemu dengan tunangannya. Suatu hari, seorang nenek baik hati tengah mencari ikan di sungai. Kemudian, ia menemukan keong emas jelmaan Candra Kirana. Dia membawanya pulang dan meletakkannya di tempayan. Esok harinya, nenek itu kembali mencari ikan tetapi tak menemukan seekor pun. Saat kembali ke rumah, dia kaget melihat makanan enak yang sudah tersedia di atas meja. Kejadian serupa terulang beberapa kali. Nenek itu akhirnya menyadari bahwa makanan itu dimasak oleh keong emas yang dia bawa dari sungai beberapa waktu sebelumnya. Keong emas tersebut berubah menjadi gadis cantik, Candra Kirana, ketika memasak, tetapi kemudian kembali ke wujud semula setelah selesai. Sementara itu, Raden Inu Kertapati terus mencari Candra Kirana yang telah menghilang. Ia melakukannya terus-menerus, hari ke hari, dengan menyamar sebagai rakyat biasa. Mengetahui hal itu, nenek sihir mencoba menghalangi Raden Inu dengan berubah menjadi burung gagak yang berbicara. Namun, Raden Inu tak terpengaruh oleh tipu daya ini dan terus mencari kekasihnya. Cerita Keong Mas mengisahkan tentang cinta yang kuat dan tekad untuk menemukan kembali kekasih yang hilang. Cerita ini mengandung unsur-unsur magis berupa kutukan nenek sihir yang sekaligus menjadi bumbu misteri dalam pengisahannya";

  final String _audioAssetPath = 'assets/voice.mp3';

  late final AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  double _playbackSpeed = 1.0;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.setUrl(_audioAssetPath);
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.COMPLETED || state == PlayerState.STOPPED) {
        setState(() {
          _isPlaying = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _storySummary,
            style: const TextStyle(fontSize: 16.0),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: _isPlaying ? null : _playAudio,
              ),
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: _isPlaying ? _stopAudio : null,
              ),
              IconButton(
                icon: Icon(Icons.speed),
                onPressed: _showSpeedDialog,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _playAudio() async {
    await _audioPlayer.setPlaybackRate(_playbackSpeed);
    await _audioPlayer.play(_audioAssetPath, isLocal: true);
    setState(() {
      _isPlaying = true;
    });
  }


  void _stopAudio() {
    _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  Future<void> _showSpeedDialog() async {
    final selectedSpeed = await showDialog<double>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pilih Kecepatan Pemutaran'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Normal (1.0x)'),
                onTap: () {
                  Navigator.of(context).pop(1.0);
                },
              ),
              ListTile(
                title: Text('Kecepatan (2.0x)'),
                onTap: () {
                  Navigator.of(context).pop(2.0);
                },
              ),
              ListTile(
                title: Text('Kecepatan (3.0x)'),
                onTap: () {
                  Navigator.of(context).pop(3.0);
                },
              ),
              ListTile(
                title: Text('Kecepatan (4.0x)'),
                onTap: () {
                  Navigator.of(context).pop(4.0);
                },
              ),
            ],
          ),
        );
      },
    );
    if (selectedSpeed != null) {
      setState(() {
        _playbackSpeed = selectedSpeed;
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();}
}