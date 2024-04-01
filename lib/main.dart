import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

/// 初期化をinitState()で行う為に、Statefulを選択。
/// constructorの中で、非同期処理は呼ばないのセオリーのようだ。
class _HomeState extends State<Home> {
  final FlutterTts tts = FlutterTts();
  final String _text1 = 'Hello, World!. ABC.';
  final String _text2 = 'おはよう。こんにちは。松田です。';

  @override
  void initState() {
    super.initState();
    initializeTts();
  }

  initializeTts() async {
    await tts.setLanguage('ja-JA');
    await tts.setSpeechRate(0.6);
    await tts.setPitch(1.0);
    await tts.awaitSpeakCompletion(false); // 発話の完了まで待機。
    await tts.awaitSynthCompletion(true); // ファイルの合成まで待機。
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Material3 Theme'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  await tts.speak(_text1);
                },
                child: const Text('Hello')),
            ElevatedButton(
                onPressed: () async {
                  await tts.speak(_text2);
                },
                child: const Text('おはよう')),
          ],
        ),
      ),
    );
  }
}
