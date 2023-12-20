class ParticipantModel {
  final String name;
  final String surname;
  final String email;
  final bool isConfirmed;

  ParticipantModel({
    required this.name,
    required this.surname,
    required this.email,
    required this.isConfirmed,
  });

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return ParticipantModel(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      isConfirmed: json['isConfirmed'],
    );
  }
}
