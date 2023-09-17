import 'package:flutter/material.dart';

class MyShadows {
  static const List<BoxShadow> xs = [
    BoxShadow(
      color: Color(0x0d101828),
      spreadRadius: 0,
      blurRadius: 2,
      offset: Offset(0, 1), // changes position of shadow
    )
  ];
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x0f101828),
      spreadRadius: 0,
      blurRadius: 2,
      offset: Offset(0, 1), // changes position of shadow
    ),
    BoxShadow(
      color: Color(0x1a101828),
      spreadRadius: 0,
      blurRadius: 3,
      offset: Offset(0, 1), // changes position of shadow
    ),
  ];
  static const List<BoxShadow> md = [
    BoxShadow(
      color: Color(0x0f101828),
      spreadRadius: -2,
      blurRadius: 4,
      offset: Offset(0, 2), // changes position of shadow
    ),
    BoxShadow(
      color: Color(0x1a101828),
      spreadRadius: -2,
      blurRadius: 8,
      offset: Offset(0, 4), // changes position of shadow
    ),
  ];
  static const List<BoxShadow> lg = [
    BoxShadow(
      color: Color(0x08101828),
      spreadRadius: -2,
      blurRadius: 6,
      offset: Offset(0, 4), // changes position of shadow
    ),
    BoxShadow(
      color: Color(0x14101828),
      spreadRadius: -4,
      blurRadius: 16,
      offset: Offset(0, 12), // changes position of shadow
    ),
  ];
  static const List<BoxShadow> xl = [
    BoxShadow(
      color: Color(0x08101828),
      spreadRadius: -4,
      blurRadius: 8,
      offset: Offset(0, 8), // changes position of shadow
    ),
    BoxShadow(
      color: Color(0x14101828),
      spreadRadius: -4,
      blurRadius: 24,
      offset: Offset(0, 20), // changes position of shadow
    ),
  ];
  static const List<BoxShadow> xl2 = [
    BoxShadow(
      color: Color(0x2e101828),
      spreadRadius: -12,
      blurRadius: 48,
      offset: Offset(0, 24), // changes position of shadow
    ),
  ];
  static const List<BoxShadow> xl3 = [
    BoxShadow(
      color: Color(0x24101828),
      spreadRadius: -12,
      blurRadius: 64,
      offset: Offset(0, 32), // changes position of shadow
    ),
  ];
}
