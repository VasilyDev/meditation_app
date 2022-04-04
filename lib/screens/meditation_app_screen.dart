import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../models/item_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Он будет у нас менять состояние, поэтому это будет stful

class MeditationAppScreen extends StatefulWidget {
  const MeditationAppScreen({Key? key}) : super(key: key);

  @override
  State<MeditationAppScreen> createState() => _MeditationAppScreenState();
}

class _MeditationAppScreenState extends State<MeditationAppScreen> {
  final List<Item> items = [
    Item(
        name: 'Forest',
        imagePath: 'meditation_images/forest.jpg',
        audioPath: 'meditation_audios/forest.mp3'),
    Item(
        name: 'Night',
        imagePath: 'meditation_images/night.jpeg',
        audioPath: 'meditation_audios/night.mp3'),
    Item(
        name: 'Ocean',
        imagePath: 'meditation_images/ocean.jpeg',
        audioPath: 'meditation_audios/ocean.mp3'),
    Item(
        name: 'Waterfall',
        imagePath: 'meditation_images/waterfall.jpeg',
        audioPath: 'meditation_audios/waterfall.mp3'),
    Item(
        name: 'Wind',
        imagePath: 'meditation_images/wind.jpeg',
        audioPath: 'meditation_audios/wind.mp3'),
    Item(
        name: 'Rain',
        imagePath: 'meditation_images/rain.jpg',
        audioPath: 'meditation_audios/rain.mp3'),
    Item(
        name: 'Cikadas',
        imagePath: 'meditation_images/cikada.jpg',
        audioPath: 'meditation_audios/cikady.mp3'),
    Item(
        name: 'Frogs',
        imagePath: 'meditation_images/frogs.jpg',
        audioPath: 'meditation_audios/frogs.mp3'),
  ];

  final AudioPlayer audioPlayer = AudioPlayer();

  // ? значит что оно может быть нулом
  int? playingIndex;

  //этот метод можно записать в тернарный оператор одной строчкой
  // Widget showIcon(int currentIndex) {
  //   if (playingIndex == currentIndex) {
  //     return FaIcon(FontAwesomeIcons.stop);
  //   } else {
  //     return FaIcon(FontAwesomeIcons.play);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  'meditation_background_fotos/niek-doup-OuuMTjwEP-o-unsplash.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: ListView.builder(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(items[index].imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ListTile(
                      title: Text(items[index].name),
                      leading: IconButton(
                          icon: playingIndex == index
                              ? FaIcon(FontAwesomeIcons.stop)
                              : FaIcon(FontAwesomeIcons.play),
                          onPressed: () async {
                            if (playingIndex == index) {
                              setState(() {
                                playingIndex = null;
                              });
                              audioPlayer.stop();
                            } else {
                              try {
                                await audioPlayer
                                    .setAsset(items[index].audioPath)
                                    .catchError((onError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0)),
                                          duration: const Duration(
                                              milliseconds: 2300),
                                          backgroundColor: Colors.pinkAccent
                                              .withOpacity(0.5),
                                          content: Text(
                                              'Ooops, an error has occured...')));
                                });
                                audioPlayer.play();
                                setState(() {
                                  playingIndex = index;
                                });
                              } catch (error, s) {
                                print('Oops, an error has occured:\n $error');
                                print('Stack trace:\n $s');
                              }
                              ;
                            }
                            ;
                          }),
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
