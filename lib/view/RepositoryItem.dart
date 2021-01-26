import 'package:app/repository/github/GetArtifactory.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoEntryItem extends StatelessWidget {
  const RepoEntryItem(this.index, this.artifact);
  final int index;
  final ArtifactsModel artifact;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: PageStorageKey<int>(artifact.id),
      title: Text(artifact.name),
      children: [RepoEntryItemChild(artifact)],
    );
  }
}

class RepoEntryItemChild extends StatelessWidget {
  RepoEntryItemChild(this.artifact);
  final ArtifactsModel artifact;

  // https://flutter.dev/docs/development/ui/layout#card
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(artifact.nodeId),
          leading: Text('nodeId'),
        ),
        ListTile(
            title: Text(artifact.archiveDownloadUrl),
            leading: Text('archiveDownloadUrl'),
            subtitle: Text(
                (artifact.sizeInBytes / 1000 / 1000).round().toString() + "MB"),
            onTap: () async {
              if (await canLaunch(artifact.archiveDownloadUrl))
                await launch(artifact.archiveDownloadUrl);
            }),
        ListTile(
          title: Text(artifact.updatedAt),
          leading: Text('updatedAt'),
        ),
        ListTile(
          title: Text(artifact.expiresAt),
          leading: Text('expiresAt'),
        ),
      ],
    );
  }
}
