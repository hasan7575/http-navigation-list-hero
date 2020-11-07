class Photo{
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;
  Photo({data}){
    albumId=data['albumId'];
    id=data['id'];
    title=data['title'];
    url=data['url'];
    thumbnailUrl=data['thumbnailUrl'];
  }

}