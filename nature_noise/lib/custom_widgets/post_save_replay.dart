import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:nature_noise/screens/prompt_screen.dart';

class PostSaveReplay extends StatefulWidget {
  final String url;
  final String username;
  final String soundname;
  final String? prompt;
  const PostSaveReplay({
    super.key,
    required this.url,
    required this.username,
    required this.soundname,
    this.prompt, 
    });

  @override
  State<PostSaveReplay> createState() => _PostSaveReplayState();
}

class _PostSaveReplayState extends State<PostSaveReplay> {
  late AudioPlayer replay;
  bool repeat = false;
  Duration timeTotal = Duration.zero;
  Duration circlePos = Duration.zero;
  double sliderVal = 0;
  bool isSeek = false;
  late Stream<Duration> listenPosition;
  late Stream<PlayerState> statePlay;

  //initialise audioplayer
  @override
  void initState(){
    super.initState();
    replay = AudioPlayer();
    replay.setUrl(widget.url);

    replay.durationStream.listen((dur){
      if(dur != null && dur != Duration.zero && mounted ){
        setState(() {
          timeTotal = dur;
        });
      }
    });

    //listens for the slider button position
    replay.positionStream.listen((pos){
      if (mounted && !isSeek){
        setState(() {
          sliderVal = pos.inMilliseconds.toDouble();
        });
        if (timeTotal == Duration.zero){
          timeTotal = pos + const Duration(seconds: 1);
        }
      }
    });
    statePlay = replay.playerStateStream;
  }

  //loop function uses just_audio library
  void makeRepeat(){
    setState(() {
      repeat = !repeat;
      replay.setLoopMode(repeat? LoopMode.one : LoopMode.off);
    });
  }

  void playPause(){
    if (replay.playing){
      replay.pause();
    }else{
      replay.play();
    }
  }

  //format the time to structured with the minute and 1 place value and second at 10 placevalue
  String sliderTimeStructure(Duration timeAt){
    String digitOne (int n) => n.toString().padLeft(1,'0');
    String digitTwo (int n) => n.toString().padLeft(2,'0');
    final min = digitOne(timeAt.inMinutes.remainder(60));
    final sec = digitTwo(timeAt.inSeconds.remainder(60));
    return "$min:$sec";
  }

  @override
  void dispose(){
    replay.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxSlider = timeTotal.inMilliseconds > 0 ? timeTotal.inMilliseconds.toDouble() : 1.0;
    return SizedBox(
      width: 400,
      height: 200,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                ),
        child: Column(
          children: [
            SizedBox( height: 40),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                thumbColor: Color(0xFFFFDB02),
                activeTrackColor: Colors.brown
              ),
              child: Slider(
                value: sliderVal.clamp(0, maxSlider),
                min: 0,
                max: maxSlider,
                onChangeStart: (val){
                  isSeek = true;
                },
                onChanged: (val){
                  setState(() {
                    sliderVal = val;
                  });
                },
                onChangeEnd: (val){
                  replay.seek(Duration(milliseconds: val.toInt()));
                  isSeek = false;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(sliderTimeStructure(Duration(milliseconds: sliderVal.toInt()))),
                ],
              ),
            ),
            Row(
              mainAxisAlignment:  MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('soundname: ${widget.soundname}'),
                      SizedBox(height: 10),
                      Text('username: ${widget.username}'),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.favorite_border,
                      size: 25,
                      ),
                    StreamBuilder<PlayerState>(
                      stream: statePlay, 
                      builder: (context, snapshot){
                        final play = snapshot.data?.playing ??false;
                        return IconButton(
                          onPressed: playPause,
                          icon: Icon(
                            play? Icons.pause : Icons.play_arrow,
                            size:40,
                          )
                        );
                      }
                      ),
                    IconButton(
                      onPressed: makeRepeat, 
                      icon: Icon(
                        Icons.repeat,
                        size: 30,
                        color: repeat? Colors.red : Colors.black
                        )
                      ),
                  ],
                ),
              ],
            ),
            Center(
              child: Column(
                children: [
                  Text("read prompt"),
                  IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PromptScreen(
                        url: widget.url,
                        soundname: widget.soundname,
                        prompt: widget.prompt ?? '',
                        )));
                    }, 
                    icon: Icon(Icons.expand_more))
                ],
              )
            )
          ],
        )
      )
    );
  }
}