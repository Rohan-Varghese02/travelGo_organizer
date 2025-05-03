class RequestData {
  final String subject;
  final String content;
  final String response;
  final String organizerUid;
  final String? requestId;

  RequestData({
    required this.subject,
    required this.content,
    required this.response,
    required this.organizerUid,
    this.requestId,
  });

  Map<String, dynamic> toMap(String requestId) {
    return {
      'subject': subject,
      'content': content,
      'response': response,
      'organizerUid': organizerUid,
      'requestId': requestId,
    };
  }

  factory RequestData.fromMap(Map<String, dynamic> doc) {
    return RequestData(
      subject: doc['subject'] ?? '',
      content: doc['content'] ?? '',
      response: doc['response']?? '',
      organizerUid: doc['organizerUid']?? '',
      requestId: doc['requestId']?? '',
    );
  }
}
