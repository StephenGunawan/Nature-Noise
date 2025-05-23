import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class TempReplay extends StatefulWidget {
  final String url;
  const TempReplay({super.key, required this.url});

  @override
  State<TempReplay> createState() => _TempReplayState();
}

class _TempReplayState extends State<TempReplay> {
  late AudioPlayer replay;
  bool repeat = false;
  Duration timeTotal = Duration.zero;
  Duration circlePos = Duration.zero;
  late Stream<Duration> listenPosition;
  late Stream<PlayerState> statePlay;

  @override
  void initState(){
    super.initState();
    replay = AudioPlayer();

    replay.setUrl(widget.url).then((duration){
        if(duration != null){
          setState(() {
            timeTotal = duration;
          });
        }
      }
    );

    replay.playerStateStream.listen((state) {
        if(state.processingState == ProcessingState.completed && repeat){
          replay.seek(Duration.zero);
          replay.play();
        }
      }
    );

    replay.positionStream.listen((pos){
        setState(() {
          circlePos = pos;
        });
      }
    );

    listenPosition = replay.positionStream;
    statePlay = replay.playerStateStream;
  }

  void makeRepeat(){
    if (!repeat){
      repeat = true;
    }else{
      repeat = false;
    }
  }

  void playPause(){
    if (replay.playing){
      replay.pause();
    }else{
      replay.play();
    }
  }

  @override
  void dispose(){
    replay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Column(
          children: [
            Slider(
              value: circlePos.inMilliseconds.clamp(0, timeTotal.inMilliseconds).toDouble(),
              min: 0,
              max: timeTotal.inMilliseconds.toDouble(),
              onChanged: (val){
                replay.seek(Duration(milliseconds: val.toInt()));
              }
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border),
                StreamBuilder<PlayerState>(
                  stream: statePlay, 
                  builder: (context, snapshot){
                    final play = snapshot.data?.playing ??false;
                    return IconButton(
                      onPressed: playPause,
                      icon: Icon(
                        play? Icons.pause : Icons.play_arrow
                      )
                    );
                  }
                  ),
                IconButton(
                  onPressed: makeRepeat, 
                  icon: Icon(Icons.repeat)
                  ),
              ],
            )
          ],
        )
      )
    );
  }
}