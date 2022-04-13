import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xmltranslator/button.dart';
import 'package:xmltranslator/xmlreader.dart';

void main() {
  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage("text"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage(String text, {Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final _searchValue = TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  String _translatedText = "translted";
  String _text2 = "drugi tekst";

  bool _isWord = false;

  // _isWord =

  @override
  void initState() {
    getXmlFile(context, _text2, _translatedText, _isWord);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 47, 47, 47),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 47, 47, 47),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Tran",
                      style: GoogleFonts.overpass(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                  TextSpan(
                      text: "Slate",
                      style: GoogleFonts.overpass(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                ]),
              ),
            ],
          ),
          elevation: 20,
        ),
        body:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Text(
            "Type XML File",
            style: GoogleFonts.overpass(
                fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 104.0),
            child: TextField(
              controller: _searchValue,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Enter Text",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Center(child: ButtonClass(
            onpressed: () {
              getXmlFile(context, _text2, _isWord, _translatedText);
              setState(() {
                _text2 = _searchValue.text;
                _translatedText = "jest";
                // if (_isWord == true) {
                //   _translatedText = "jest";
                // } else {
                //   _translatedText = "Nie ma";
                // }
              });
            },
          )),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Szukany tekst:",
                style: GoogleFonts.actor(color: Colors.white, fontSize: 20)),
            Text(_text2,
                textAlign: TextAlign.center,
                style: GoogleFonts.overpass(
                  color: Colors.green,
                  fontSize: 30,
                ))
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Tłumaczenie:",
                style: GoogleFonts.actor(color: Colors.white, fontSize: 20)),
            Text(_translatedText,
                textAlign: TextAlign.center,
                style: GoogleFonts.overpass(
                  color: Colors.red,
                  fontSize: 30,
                ))
          ])
        ]));
  }
}
