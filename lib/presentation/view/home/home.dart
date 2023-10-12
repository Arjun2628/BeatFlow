import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/presentation/view/play_song/play_song.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  requestPermission() {
    Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    final AudioPlayer audioPlayer = AudioPlayer();
    final _audioQuory = OnAudioQuery();

    playSong(String uri) {
      try {
        audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri)));
        audioPlayer.play();
      } catch (e) {
        print('error in parsing uri');
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Music Player',
          style: TextStyle(color: Colors.white),
        ),
        leading: Icon(
          Icons.home,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
          child: FutureBuilder<List<SongModel>>(
        future: _audioQuory.querySongs(
            orderType: OrderType.ASC_OR_SMALLER,
            uriType: UriType.EXTERNAL,
            sortType: null,
            ignoreCase: true),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              if (snapshot.data == null) {
                return CircularProgressIndicator();
              }
              if (snapshot.data!.isEmpty) {
                return Text('No songs found');
              }
              final songUri = snapshot.data![index].uri;

              return GestureDetector(
                onTap: () async {
                  await playSong(snapshot.data![index].uri!);
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) {
                  //     return PlaySong();
                  //   },
                  // ));
                },
                onLongPress: () {
                  showBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        color: Colors.black.withOpacity(0.5),
                        height: 400,
                        width: double.infinity,
                      );
                    },
                  );
                },
                child: Container(
                  color: Colors.black,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage:
                          AssetImage("lib/data/local/images/music.png"),
                    ),
                    title: Text(
                      snapshot.data![index].displayNameWOExt,
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      snapshot.data![index].fileExtension,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          );
        },
      )),
    );
  }
}
