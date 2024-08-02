import 'package:blog_app/widgets/desktop_layout.dart';
import 'package:blog_app/widgets/mobile_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post_model.dart';
import '../widgets/responsive_layout.dart';
import '../services/weather_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String temperature = 'Loading...';

  @override
  void initState() {
    super.initState();
    fetchWeather();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PostModel>(context, listen: false).fetchPosts();
    });
  }

  Future<void> fetchWeather() async {
    final weatherService = WeatherService();
    final temp = await weatherService.getTemperature();
    setState(() {
      temperature = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        mobileBody: MobileLayout(temperature: temperature),
        desktopBody: DesktopLayout(temperature: temperature),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPostDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }


  void _showAddPostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String content = '';
        return AlertDialog(
          title: Text('Add New Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(hintText: "Title"),
                onChanged: (value) {
                  title = value;
                },
              ),
              TextField(
                decoration: InputDecoration(hintText: "Content"),
                onChanged: (value) {
                  content = value;
                },
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
              child: Text('Add'),
              onPressed: () {
                if (title.isNotEmpty && content.isNotEmpty) {
                  Provider.of<PostModel>(context, listen: false).addPost(title, content);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}