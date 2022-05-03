import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xmltranslator/painter.dart';
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
    myFocusNode = FocusNode();
  }

  late FocusNode myFocusNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 77, 77, 77),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 47, 47, 47),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "T r a n ",
                      style: GoogleFonts.overpass(
                          fontWeight: FontWeight.bold, fontSize: 30)),
                  TextSpan(
                      text: " S l a t e",
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
        body: SafeArea(
            child: Column(children: [
          Expanded(
            flex: 1,
            child: TextField(
              style: GoogleFonts.overpass(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 35),
              controller: _searchValue,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter Word",
              ),
              onEditingComplete: () async {
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
                    _translatedText1 = "Nie ma takowego słowa";
                  });
                  print("wartosc po funkcji:$_translatedText2");
                }
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CustomPaint(
              foregroundPainter: LinePainter(),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Text(_translatedText1,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.overpass(
                    color: Colors.red,
                    fontSize: 30,
                  )),
            ),
          ),
        ])));
  }
}
