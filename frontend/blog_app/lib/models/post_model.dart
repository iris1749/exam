import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'post.dart';

class PostModel extends ChangeNotifier {
  List<Post> _displayedPosts = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  List<Post> get displayedPosts => _displayedPosts;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  Future<void> fetchPosts({bool refresh = false}) async {
    if (_isLoading || (!refresh && !_hasMore)) return;
    
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/posts?page=$_currentPage&size=10')
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> postsJson = data['content'];
        final newPosts = postsJson.map((json) => Post.fromJson(json)).toList();
        
        if (refresh) {
          _displayedPosts = newPosts;
          _currentPage = 2;
        } else {
          _displayedPosts.addAll(newPosts);
          _currentPage++;
        }
        
        _hasMore = data['last'] == false;
      } else {
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> refreshPosts() async {
    _currentPage = 1;
    _hasMore = true;
    await fetchPosts(refresh: true);
  }

  void loadMorePosts() {
    if (!_isLoading && _hasMore) {
      fetchPosts();
    }
  }

  Future<void> addPost(String title, String content) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/posts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'title': title,
          'content': content,
        }),
      );

      if (response.statusCode == 201) {
        final newPost = Post.fromJson(jsonDecode(response.body));
        _displayedPosts.insert(0, newPost);
        notifyListeners();
      } else {
        throw Exception('Failed to create post');
      }
    } catch (e) {
      print('Error adding post: $e');
    }
  }

  Future<void> updatePost(int id, String title, String content) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:8080/posts/$id'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'title': title,
          'content': content,
        }),
      );

      if (response.statusCode == 200) {
        final updatedPost = Post.fromJson(jsonDecode(response.body));
        final index = _displayedPosts.indexWhere((post) => post.id == id);
        if (index != -1) {
          _displayedPosts[index] = updatedPost;
          notifyListeners();
        }
      } else {
        throw Exception('Failed to update post');
      }
    } catch (e) {
      print('Error updating post: $e');
    }
  }

  Future<void> deletePost(int id) async {
    try {
      final response = await http.delete(Uri.parse('http://localhost:8080/posts/$id'));

      if (response.statusCode == 204) {
        _displayedPosts.removeWhere((post) => post.id == id);
        notifyListeners();
      } else {
        throw Exception('Failed to delete post');
      }
    } catch (e) {
      print('Error deleting post: $e');
    }
  }
}