class CompletionModel {
  List<String>? message;

  CompletionModel({this.message});

  CompletionModel.fromJson(Map<String, dynamic> json) {
    message = json['message'].cast<String>();
  }




}

  

