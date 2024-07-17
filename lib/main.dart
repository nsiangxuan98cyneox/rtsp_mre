import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then(
        (_) {
      runApp(
        const MyApp(),
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VlcPlayerController _videoPlayerController;

  Future<void> initializePlayer() async {}

  /// Working on Android but not on IOS,
  /// iOS > https://developer.apple.com/documentation/bundleresources/entitlements/com_apple_developer_networking_multicast

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VlcPlayerController.network(
      // 'rtsp://192.168.50.247/554/Streaming/channels/101',  // RTSP without Authentication , HIKVISION
      // 'rtsp://admin:Qweqwe11!@192.168.50.247/554/Streaming/channels/101', // RTSP with Authentication
      // 'rtsp://admin:Fple2628@192.168.50.2:554/cam/realmonitor?channel=1&subtype=1', // AIHUA
      // 'rtsp://admin:Fple2628@192.168.50.31:554/cam/realmonitor?channel=3&subtype=1', // CYNEOX
      'rtsp://admin:Fple2628@175.140.166.89:554/cam/realmonitor?channel=3&subtype=1',
      // 'https://media.w3.org/2010/05/sintel/trailer.mp4',
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(
        // extras : ['--rtsp-tcp'],
        // rtp: VlcRtpOptions([
        //   VlcRtpOptions.rtpOverRtsp(true),
        // ]),
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _videoPlayerController.stopRendererScanning();
    await _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Center(
              child: VlcPlayer(
                controller: _videoPlayerController,
                aspectRatio: 16 / 9,
                placeholder: const Center(child: CircularProgressIndicator(color: Colors.red,),),
              ),
            ),
          ],
        ));
  }
}