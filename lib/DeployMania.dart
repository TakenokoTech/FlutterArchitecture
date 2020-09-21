import 'package:app/repository/github/GetArtifactory.dart';
import 'package:app/repository/github/SearchRepositories.dart';
import 'package:app/view/RepositoryItem.dart';
import 'package:flutter/material.dart';

class DeployMania extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deploy Mania',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DeployManiaPage(title: 'Deploy Mania'),
    );
  }
}

class DeployManiaPage extends StatefulWidget {
  DeployManiaPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _DeployManiaPageState createState() => _DeployManiaPageState();
}

class _DeployManiaPageState extends State<DeployManiaPage> {
  List<ArtifactsModel> data = [];

  void _update() {
    setState(() {
      getArtifactory().then((value) {
        setState(() {
          data = value;
        });
        // value.forEach((el) => print(el.name));
      });
      // searchRepositories("typescript").then((repositories) {
      //   setState(() {
      //     repositories.forEach((element) {
      //       print(element.fullName);
      //     });
      //   });
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            RepoEntryItem(index, data[index]),
        itemCount: data.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _update,
        tooltip: 'Update',
        child: Icon(Icons.update),
      ),
    );
  }
}
