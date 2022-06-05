import 'package:flutter/material.dart';
import 'package:xml/xml.dart' as xml;

Future<List<String>> getXmlFile(
    BuildContext context, _searchValue, xmlString) async {
  String _topSearchValue = _searchValue.toString().toUpperCase();

  var raw = xml.XmlDocument.parse(xmlString);

  var elements = raw.findAllElements(_topSearchValue);

  return elements.map((node) {
    return (node.text);
  }).toList();
}
