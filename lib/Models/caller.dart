import 'package:call_log/call_log.dart';

class NotedCaller {
  NotedCaller(
    this.name,
    this.cachedMatchedNumber,
    this.cachedNumberLabel,
    this.cachedNumberType,
    this.myCallType,
    this.duration,
    this.formattedNumber,
    this.id,
    this.notes,
    this.number,
    this.phoneAccountId,
    this.simDisplayName,
    this.timestamp,
  );
  NotedCaller.empty();
  NotedCaller.fromCallLog(CallLogEntry log, this.notes) {
    name = log.name;
    number = log.number;
    formattedNumber = log.formattedNumber;
    myCallType = _convertType(log.callType);
    duration = log.duration;
    timestamp = log.timestamp;
    cachedNumberType = log.cachedNumberType;
    cachedNumberLabel = log.cachedNumberLabel;
    cachedMatchedNumber = log.cachedMatchedNumber;
    simDisplayName = log.simDisplayName;
    phoneAccountId = log.phoneAccountId;
    id = log.id;
  }
  String get displayName =>
      (name != null && name != "") ? name! : (number ?? "No Name");
  bool get hasName => name != null || name == "";

  /// contact name
  String? name;

  /// contact number
  String? number;

  /// formatted number based on phone locales
  String? formattedNumber;

  /// type of call entry. see CallType
  MyCallType? myCallType;

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
  List<Note> notes = [];

  MyCallType _convertType(CallType? type) {
    switch (type) {
      case CallType.incoming:
        return MyCallType.incoming;
      case CallType.outgoing:
        return MyCallType.outgoing;
      case CallType.missed:
        return MyCallType.missed;
      case CallType.rejected:
        return MyCallType.rejected;
      case CallType.blocked:
        return MyCallType.blocked;
      default:
        return MyCallType.unknown;
    }
  }
}

/// All possible call types
enum MyCallType {
  /// incoming call
  incoming,

  /// outgoing call
  outgoing,

  /// missed incoming call
  missed,

  /// rejected incoming call
  rejected,

  /// blocked incoming call
  blocked,

  /// unknown type of call
  unknown,
}

class Note {
  final NoteType type;
  final String content; // for plain text or raw text
  final List<String>? items; // optional list for lists
  final List<bool>? checked; // optional checkbox states

  Note({required this.type, required this.content, this.items, this.checked});

  Map<String, dynamic> toJson() => {
    'type': type.name,
    'content': content,
    'items': items,
    'checked': checked,
  };
  @override
  noSuchMethod(Invocation invocation) {
    // TODO: implement noSuchMethod
    return super.noSuchMethod(invocation);
  }

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    type: NoteType.values.firstWhere((e) => e.name == json['type']),
    content: json['content'] ?? '',
    items: (json['items'] as List?)?.cast<String>(),
    checked: (json['checked'] as List?)?.cast<bool>(),
  );
}

enum NoteType { plainText, orderedList, unorderedList, checkboxList }
