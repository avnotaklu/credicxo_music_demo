import 'package:credicxo_music_app/model/model.dart';

class MusicMatchResponse<B extends Model> {
  Message? message;

  MusicMatchResponse({this.message});

  MusicMatchResponse.fromJson(Map<String, dynamic> json,
      B Function(Map<String, dynamic>) bodyParser) {
    message = json['message'] != null
        ? new Message<B>.fromJson(json['message'], bodyParser)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    return data;
  }
}

class Message<B extends Model> {
  Header? header;
  B? body;

  Message({this.header, this.body});

  Message.fromJson(Map<String, dynamic> json,
      B Function(Map<String, dynamic>) bodyParser) {
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    body = json['body'] != null ? bodyParser(json['body']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.header != null) {
      data['header'] = this.header!.toJson();
    }
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    return data;
  }
}

class Header {
  int? statusCode;
  double? executeTime;

  Header({this.statusCode, this.executeTime});

  Header.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    executeTime = json['execute_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_code'] = this.statusCode;
    data['execute_time'] = this.executeTime;
    return data;
  }
}
