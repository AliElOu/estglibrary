import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class BookArguments {
  final String isbn;
  final String title;
  final String image;
  final String categorie;
  final String actor;
  final int nump;
  final String description;
  final int qt;
  final bool ck;

  BookArguments(
    this.isbn,
    this.title,
    this.image,
    this.categorie,
    this.actor,
    this.nump,
    this.description,
    this.qt,
    this.ck,
  );
}

class CategotieArguments {
  final String Name;
  final String image;

  CategotieArguments(
    this.Name,
    this.image,
  );
}

class CategotieBookArguments {
  final List ll;
  CategotieBookArguments(
    this.ll,
  );
}

class User {
  final String name;
  final String image;
  final String email;
  final String cne;
  final String filliere;

  User(
    this.name,
    this.image,
    this.email,
    this.cne,
    this.filliere,
  );
}

class emailll {
  final String mail;

  emailll(
    this.mail,
  );
}
