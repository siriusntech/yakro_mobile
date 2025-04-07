import 'package:flutter/material.dart';
import 'package:jaime_yakro/Helpers/helpers.dart';
import 'package:jaime_yakro/Providers/path_providers.dart';

class CommentaireElement extends StatefulWidget {
  const CommentaireElement(
      {super.key, this.commentaireModel, required this.index});
  final CommentaireModel? commentaireModel;
  final int index;
  @override
  State<CommentaireElement> createState() => _CommentaireElementState();
}

class _CommentaireElementState extends State<CommentaireElement> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white,
      ),
      title: Text('Anonyme ${widget.index + 1}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.commentaireModel!.commentaire}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
          Text(
            '${Helpers.formatDateHour(widget.commentaireModel!.createdAt.toString())}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          )
        ],
      ),
    );
  }
}
