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

}
