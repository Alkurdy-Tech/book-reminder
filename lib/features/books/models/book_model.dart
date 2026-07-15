class BookModel {
  final int? id;
  final String title;
  final String author;
  final int totalPages;
  final int currentPage;
  final bool isFinished;

  BookModel({
    this.id,
    required this.title,
    required this.author,
    required this.totalPages,
    this.currentPage = 0,
    this.isFinished = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'totalPages': totalPages,
      'currentPage': currentPage,
      'isFinnished': isFinished ? 1 : 0,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'],
      title: map['title'],
      author: map['author'],
      totalPages: map['totalPages'],
      currentPage: map['currentPage'],
      isFinished: map['isFinnished'] == 1,
    );
  }
}
