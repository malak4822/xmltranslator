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

String _typedText = "";
String _translatedText1 = "";
bool _isWord = false;
final _searchValue = TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    getXmlFile(context, _searchValue.text, context);
    super.initState();
  }

  late FocusNode myFocusNode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 77, 77, 77),
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
                      text: " Slate",
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
            child: Container(
              color: Colors.white12,
              child: Center(
                child: TextField(
                  maxLines: null,
                  expands: true,
                  keyboardType: TextInputType.text,
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
                  onChanged: (a) async {
                    final _textToUpper = _searchValue.text.toUpperCase();
                    final _textToLower = _searchValue.text.toLowerCase();
                    var _everyTypeOfText = <String>[
                      _searchValue.text,
                      _textToLower,
                      _textToUpper
                    ];
                    print(_everyTypeOfText);

                    String xmlString = await DefaultAssetBundle.of(context)
                        .loadString("assets/test.xml");
                    var _translatedText2 =
                        await getXmlFile(context, _searchValue.text, xmlString);

                    setState(() {
                      _typedText = _searchValue.text;
                    });

                    if (_everyTypeOfText.any((element) => element == "dwd")) {
                      print("prawda");
                    } else {
                      print("falsz");
                    }

                    if (xmlString.contains(_typedText)) {
                      _isWord = true;
                      setState(() {
                        _translatedText1 = _translatedText2.first.toString();
                      });
                      print("tłumaczenie wyrazu:$_translatedText2");
                    } else {
                      _isWord = false;
                      setState(() {
                        _translatedText1 = "Nie ma takowego słowa";
                      });
                      print("nie ma tłumaczenia");
                    }
                    if (_isWord == false) {
                      _translatedText1 = _searchValue.text;
                    }
                  },
                ),
              ),
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
                    color: Colors.white,
                    fontSize: 30,
                  )),
            ),
          ),
        ])));
  }
}
