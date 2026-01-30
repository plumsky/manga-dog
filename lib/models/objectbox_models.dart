import 'package:objectbox/objectbox.dart';

@Entity()
class Manga {
  @Id()
  int id = 0;  // ObjectBox use 0 for now, will assign unique id later

  String title;

  String? coverPath;

  String? folderPath;

  int? totalPages;
  int? currentPage;
  double? readingProgress;
  DateTime? lastReadAt;
  List<String> tags = [];

  bool isFavorite = false;
  String? description;
  String? author;

  // relationships
  final bookmarks = ToMany<Bookmark>();
  final translations = ToMany<TranslationCache>();
  final readingHistory = ToMany<ReadingHistory>();

  Manga({
    required this.title,
    this.coverPath,
    this.folderPath,
    this.totalPages,
    this.currentPage,
    this.readingProgress,
    this.lastReadAt,
    this.tags = const [],
    this.isFavorite = false,
    this.description,
    this.author,
  });
}

@Entity()
class Bookmark {
  @Id()
  int id = 0;

  String mangaIdentifier;
  int pageNumber;
  String? note;
  DateTime createdAt;
  DateTime? updatedAt;

  // relationship
  final manga = ToOne<Manga>();

  Bookmark({
    required this.mangaIdentifier,
    required this.pageNumber,
    this.note,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

@Entity()
class TranslationCache {
  @Id()
  int id = 0;

  @Index()
  String imageHash;

  String originalText;
  String translatedText;
  String sourceLang;
  String targetLang;
  DateTime createdAt;
  DateTime? lastAccessed;
  int accessCount = 0;

  final manga = ToOne<Manga>();

  TranslationCache({
    required this.imageHash,
    required this.originalText,
    required this.translatedText,
    required this.sourceLang,
    required this.targetLang,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

@Entity()
class ReadingHistory {
  @Id()
  int id = 0;

  String mangaIdentifier;
  int pageNumber;
  DateTime readAt;
  int durationSeconds;

  final manga = ToOne<Manga>();

  ReadingHistory({
    required this.mangaIdentifier,
    required this.pageNumber,
    required this.durationSeconds,
    DateTime? readAt,
  }) : readAt = readAt ?? DateTime.now();
}
