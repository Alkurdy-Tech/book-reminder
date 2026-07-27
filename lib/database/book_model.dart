class Book {
  int? id;
  String title;
  String author;
  String genre;
  String coverPath;
  int totalPages;
  int pagesRead;
  int isFinished; // 0 = still reading, 1 = finished (SQLite has no bool type)

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.coverPath,
    required this.totalPages,
    required this.pagesRead,
    this.isFinished = 0, // defaults to "not finished"
  });

  double get progress => totalPages == 0 ? 0.0 : pagesRead / totalPages;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'genre': genre,
      'coverPath': coverPath,
      'totalPages': totalPages,
      'pagesRead': pagesRead,
      'isFinished': isFinished,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      genre: map['genre'],
      coverPath: map['coverPath'],
      totalPages: map['totalPages'],
      pagesRead: map['pagesRead'],
      isFinished: map['isFinished'],
    );
  }
}