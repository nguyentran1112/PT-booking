import 'package:fitness/common/image_network_cache_common.dart';
import 'package:fitness/common/text_field/custom_outline_border_input.dart';
import 'package:fitness/models/feedback_model.dart';
import 'package:fitness/models/user_model.dart';
import 'package:fitness/screen/feedback/bloc/create_feedback_bloc.dart';
import 'package:fitness/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

class CreateFeedbackDialog extends StatefulWidget {
  const CreateFeedbackDialog({super.key, required this.user});
  final UserModel user;
  @override
  State<CreateFeedbackDialog> createState() => _CreateFeedbackDialogState();
}

class _CreateFeedbackDialogState extends State<CreateFeedbackDialog> {
  FeedbackModel feedback = FeedbackModel();

  @override
  initState() {
    super.initState();
    feedback.createdBy = Utils.getMyId(context) ?? '';
    feedback.updatedAt = feedback.createdBy;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateFeedbackBloc(),
      child: BlocBuilder<CreateFeedbackBloc, CreateFeedbackState>(
        builder: (context, state) {
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
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(Icons.close)),
                      const SizedBox(
                        width: 8,
                      ),
                      SizedBox(
                        height: 42,
                        width: 42,
                        child: ClipOval(
                          child: ImageNetworkCacheCommon(
                              base64: widget.user.avatar ?? ''),
                        ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(widget.user.name ?? ''),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  // rating bar
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 24,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      feedback.rating = rating;
                    },
                  ),

                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Nhập nội dung đánh giá',
                      contentPadding: EdgeInsets.all(12),
                      border: CustomOutlineInputBorder(),
                    ),
                    maxLines: 5,
                    onChanged: (value) {
                      feedback.content = value;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  OutlinedButton(
                      onPressed: state.status == CreateFeedbackStatus.loading
                          ? null
                          : () {
                              context.read<CreateFeedbackBloc>().add(
                                    CreateFeedback(feedback),
                                  );
                            },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 42),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      child: state.status == CreateFeedbackStatus.loading
                          ? SizedBox.square(
                              dimension: 20,
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                              ),
                            )
                          : const Text('Viết đánh giá'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
