import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

//jeśli (w pliku tekstowym [test.xml] jest słowo ze zmiennej _text2) {
// _isWord = true}
//else {"Nie znaleziono"}

Future<List<String>> getXmlFile(
    BuildContext context, _text2, _isWord, _text1) async {
  String xmlString =
      await DefaultAssetBundle.of(context).loadString("assets/test.xml");

  // if (xmlString.contains(_text2)) {
  //   print("jest slowo");
  //   _isWord = true;
  // } else {
  //   print("nie ma slowa");
  //   _isWord = false;
  // }

  var raw = xml.XmlDocument.parse(xmlString);

  var elements = raw.findAllElements(_text2);

  return elements.map((node) {
    return (node.text);
  }).toList();
}
