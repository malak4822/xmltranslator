import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

Future<List<String>> getXmlFile(
    BuildContext context, _typedText, xmlString) async {
  var raw = xml.XmlDocument.parse(xmlString);

  var elements = raw.findAllElements(_typedText);

  return elements.map((node) {
    return (node.text);
  }).toList();
}

// jeśli [if] wpisane słowo jest w XmlString {
// [warunek tak]
// przetłumacz }
// else{
// zamień _text1 na nic}
