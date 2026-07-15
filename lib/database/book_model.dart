class Book {
  int? id;
  String title;
  String author;
  String genre;
  String coverPath;
  double progress;

  Book({
    this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.coverPath,
    required this.progress,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'genre': genre,
      'coverPath': coverPath,
      'progress': progress,
    };
  }

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      genre: map['genre'],
      coverPath: map['coverPath'],
      progress: map['progress'],
    );
  }
}