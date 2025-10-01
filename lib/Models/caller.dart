class NotedCaller {
  NotedCaller();
  NotedCaller.full(
    this.name,
    this.cachedMatchedNumber,
    this.cachedNumberLabel,
    this.cachedNumberType,
    this.callType,
    this.duration,
    this.formattedNumber,
    this.id,
    this.notes,
    this.number,
    this.phoneAccountId,
    this.simDisplayName,
    this.timestamp,
  );

  /// contact name
  String? name;

  /// contact number
  String? number;

  /// formatted number based on phone locales
  String? formattedNumber;

  /// type of call entry. see CallType
  CallType? callType;

  /// duration in seconds
  int? duration;

  /// unix timestamp of call start
  int? timestamp;

  /// todo comment
  int? cachedNumberType;

  /// todo comment
  String? cachedNumberLabel;

  /// todo comment
  String? cachedMatchedNumber;

  /// SIM display name
  String? simDisplayName;

  /// PHONE account id
  String? phoneAccountId;

  /// Call log entry ID
  String? id;
  List<String> notes = List.empty();
}

/// All possible call types
enum CallType {
  /// incoming call
  incoming,

  /// outgoing call
  outgoing,

  /// missed incoming call
  missed,

  /// voicemail call
  voiceMail,

  /// rejected incoming call
  rejected,

  /// blocked incoming call
  blocked,

  /// todo comment
  answeredExternally,

  /// unknown type of call
  unknown,

  /// wifi incoming
  wifiIncoming,

  ///wifi outgoing
  wifiOutgoing,
}
