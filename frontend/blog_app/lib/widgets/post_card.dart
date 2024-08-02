import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post.dart';
import '../models/post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(post.content),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editPost(context),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deletePost(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _editPost(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = post.title;
        String content = post.content;
        return AlertDialog(
          title: Text('Edit Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "Title"),
                onChanged: (value) {
                  title = value;
                },
                controller: TextEditingController(text: post.title),
              ),
              TextField(
                decoration: InputDecoration(hintText: "Content"),
                onChanged: (value) {
                  content = value;
                },
                controller: TextEditingController(text: post.content),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                if (title.isNotEmpty && content.isNotEmpty) {
                  Provider.of<PostModel>(context, listen: false).updatePost(post.id, title, content);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deletePost(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Post'),
          content: Text('Are you sure you want to delete this post?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                Provider.of<PostModel>(context, listen: false).deletePost(post.id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}