class Participant{
  int eventId;
  String name;
  String surname;
  String email;

  Participant({
    required this.eventId,
    required this.name,
    required this.surname,
    required this.email,
  });

  factory Participant.fromString(String input) {
    // Veriyi uygun şekilde ayrıştırma
    List<String> lines = input.split('\n');

    int eventId = int.parse(lines[0].split(':')[1].trim());
    String name = lines[1].split(':')[1].trim();
    String surname = lines[2].split(':')[1].trim();
    String email = lines[3].split(':')[1].trim();

    return Participant(
      eventId: eventId,
      name: name,
      surname: surname,
      email: email,
    );
  }
}