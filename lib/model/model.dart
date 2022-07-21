// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

abstract class Model {
  Model();
  Map<String, dynamic> toJson();
  Model.fromJson(Map<String, dynamic> map);
}