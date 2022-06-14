import 'package:flutter/material.dart';

import '../style/app_style.dart';

class NoteCard extends StatelessWidget {
  final String? title;
  final String? dateTime;
  final String? note;
  final String? colorId;
  final VoidCallback? onTap;

  const NoteCard(
      {Key? key,
      this.title,
      this.dateTime,
      this.note,
      this.colorId,
      this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppStyle.cardsColor[int.parse(colorId!)],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title!,
                style: AppStyle.mainTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                dateTime!,
                style: AppStyle.dateTitle,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                note!,
                style: AppStyle.mainContent,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
