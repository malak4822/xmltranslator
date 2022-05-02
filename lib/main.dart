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
String _typedText = "finding txt";
String _translatedText1 = "translation";

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    getXmlFile(context, _searchValue.text, context);
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
                          fontWeight: FontWeight.bold, fontSize: 30)),
                  TextSpan(
                      text: "Slate",
                      style: GoogleFonts.overpass(
                          color: Colors.black,
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
            "Search Word",
            style: GoogleFonts.overpass(
                fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 104.0),
            child: TextField(
              style: GoogleFonts.overpass(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23),
              controller: _searchValue,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Enter Word",
              ),
            ),
          ),
          Center(child: ButtonClass(
            whenClick: () async {
              String xmlString = await DefaultAssetBundle.of(context)
                  .loadString("assets/test.xml");

              final _translatedText2 =
                  await getXmlFile(context, _searchValue.text, xmlString);

              setState(() {
                _typedText = _searchValue.text;
              });

              if (xmlString.contains(_typedText)) {
                setState(() {
                  _translatedText1 = _translatedText2.first.toString();
                });
              } else {
                setState(() {
                  _translatedText1 = "Brak słowa";
                });
              }

              print("wartosc po funkcji:$_translatedText2");
            },
          )),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("finding text:",
                style: GoogleFonts.actor(color: Colors.white, fontSize: 20)),
            Text(_typedText,
                textAlign: TextAlign.center,
                style: GoogleFonts.overpass(
                  color: Colors.green,
                  fontSize: 30,
                ))
          ]),
          Wrap(children: [
            Text("translation:",
                style: GoogleFonts.actor(color: Colors.white, fontSize: 20)),
            Text(_translatedText1,
                textAlign: TextAlign.center,
                style: GoogleFonts.overpass(
                  color: Colors.red,
                  fontSize: 30,
                ))
          ])
        ]));
  }
}
