class SupportModel {
  final String Subject;
  final String Description;
  final String Date;
  final String Id;

  SupportModel({
    required this.Subject,
    required this.Description,
    required this.Date,
    required this.Id,
  });

  // Convert BalanceEntry object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'Subject': Subject,
      'Description': Description,
      'date': Date,
      'Id': Id,
    };
  }

  // Create a new BalanceEntry object from a JSON object
  factory SupportModel.fromJson(Map<String, dynamic> json) {
    return SupportModel(
      Subject: json['subject'],
      Description: json['description'],
      Date: json['Date'],
      Id: json['Id'],
    );
  }
}