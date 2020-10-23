class UserModel {
  final int albumId;
  final String title;
  final String url;
  final String thumbnailUrl;
  int id;

  UserModel({
    int id,
    int albumId,
    String title,
    String url,
    String thumbnailUrl,
  })  : this.albumId = albumId,
        this.id = id,
        this.title = title,
        this.url = url,
        this.thumbnailUrl = thumbnailUrl;

  UserModel.fromJson(Map<String, dynamic> json)
      : this.albumId = json['albumId'],
        this.id = json['id'],
        this.title = json['title'],
        this.url = json['url'],
        this.thumbnailUrl = json['thumbnailUrl'];

  UserModel.fromUserId(
      int albumId, String title, String url, String thumbnailUrl)
      : this.albumId = albumId,
        this.title = title,
        this.url = url,
        this.thumbnailUrl = thumbnailUrl {
    this.id = this.albumId;
  }
}
