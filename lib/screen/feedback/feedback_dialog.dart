import 'package:fitness/models/user_model.dart';
import 'package:fitness/screen/feedback/create_feedback_dialog.dart';
import 'package:fitness/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({super.key, required this.user});
  final UserModel user;
  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Đánh giá'),
            const SizedBox(
              height: 12,
            ),
            Text((widget.user.rating ?? 0).toStringAsFixed(1)),
            RatingBarIndicator(
              itemSize: 12,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              rating: widget.user.rating ?? 0,
            ),
            const SizedBox(
              height: 12,
            ),
            OutlinedButton(
                onPressed: () {
                  if (Utils.getMyProfile(context) == null) {
                    return;
                  }
                  showDialog(
                      context: context,
                      builder: (context) =>
                          CreateFeedbackDialog(user: widget.user));
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 42),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  side: BorderSide(
                    color: Colors.grey.shade200,
                  ),
                ),
                child: const Text('Viết đánh giá'))
          ],
        ),
      ),
    );
  }
}
