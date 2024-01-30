class TaskModel {
  int id;
  String title;
  String? description;
  String status;
  List<dynamic> argb;

  TaskModel({
    required this.id,
    required this.status,
    required this.title,
    required this.argb,
    this.description,
  });

  void setId(int newId) {
    id = newId;
  }

  void setTitle(String newTitle) {
    title = newTitle;
  }

  void setDescription(String? newDescription) {
    description = newDescription;
  }

  void setStatus(String newStatus) {
    status = newStatus;
  }

  void setArgb(List<dynamic> newArgb) {
    argb = newArgb;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'argb': argb
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        status: json['status'],
        argb: json['argb']);
  }
}
