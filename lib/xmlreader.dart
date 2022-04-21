import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

//jeśli (w pliku tekstowym [test.xml] jest słowo ze zmiennej _text2) {
// jest slowo = true}
//else {"Nie znaleziono"}

Future<List<String>> getXmlFile(BuildContext context, _typedText) async {
  String xmlString =
      await DefaultAssetBundle.of(context).loadString("assets/test.xml");

  var raw = xml.XmlDocument.parse(xmlString);

  var elements = raw.findAllElements(_typedText);

  return elements.map((node) {
    return (node.text);
  }).toList();
}
