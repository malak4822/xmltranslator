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

String _shownText = "";
final _searchValue = TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    getXmlFile(context, _searchValue.text, context);
    super.initState();
  }

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
                    String xmlString = await DefaultAssetBundle.of(context)
                        .loadString("assets/test.xml");

                    var _translationOfText =
                        await getXmlFile(context, _searchValue.text, xmlString);

                    setState(() {
                      _shownText = _searchValue.text;
                    });

                    if (xmlString.contains(_searchValue.text.toUpperCase())) {
                      setState(() {
                        _shownText = _translationOfText.first.toString();
                      });
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
              child: Text(_shownText,
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
