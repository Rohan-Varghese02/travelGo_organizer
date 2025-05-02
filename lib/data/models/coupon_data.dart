class CouponData {
  final String codeName;
  final int codeDiscount;
  final int codeRedeem;
  final String postName;
  final String postUid;
  final String? couponUid;
  final bool? isActive;

  CouponData({
    required this.codeName,
    required this.codeDiscount,
    required this.codeRedeem,
    required this.postName,
    required this.postUid,
    this.couponUid,
    this.isActive, 
  });
  Map<String, dynamic> toMap(uid) {
    return {
      'codeName': codeName,
      'codeDiscount': codeDiscount,
      'codeRedeem': codeRedeem,
      'postName': postName,
      'postUid': postUid,
      'coupounUid': uid,
      'isActive': isActive ??true
    };
  }

  factory CouponData.fromMap(Map<String, dynamic> map) {
    return CouponData(
      codeName: map['codeName'] ?? '',
      codeDiscount: map['codeDiscount'] ?? '',
      codeRedeem: map['codeRedeem'] ?? '',
      postName: map['postName'] ?? '',
      postUid: map['postUid'] ?? '',
      couponUid: map['coupounUid'] ?? '',
      isActive: map['isActive']??true,
    );
  }
}


