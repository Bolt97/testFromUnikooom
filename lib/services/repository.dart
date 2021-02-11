import 'package:testbloc/models/postModel.dart';
import 'package:testbloc/services/dataService.dart';

class Repository {
  DataService _postsProvider = DataService();
  Future<List<Post>> getAllPosts() => _postsProvider.getPosts();
}
