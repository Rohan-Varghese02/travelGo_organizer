class Userdata {
  final String userUID;
  final String userImage;
  final String userEmail;
  final String userName;
  final Map<String, int> tickets;

  Userdata({
    required this.userUID,
    required this.userImage,
    required this.userEmail,
    required this.userName,
    required this.tickets,
  });

  factory Userdata.fromMap(Map<String, dynamic> doc) {
    final ticketData = doc['tickets'] as Map<String, dynamic>? ?? {};
    final parsedTickets = ticketData.map(
      (key, value) => MapEntry(key, int.tryParse(value.toString()) ?? 0),
    );

    return Userdata(
      userName: doc['userName'] ?? '',
      userUID: doc['userUID'] ?? '',
      userImage: doc['userImage'] ?? '',
      userEmail: doc['userEmail'] ?? '',
      tickets: parsedTickets,
    );
  }
}
