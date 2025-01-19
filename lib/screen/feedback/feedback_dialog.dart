import 'package:fitness/common/image_network_cache_common.dart';
import 'package:fitness/models/user_model.dart';
import 'package:fitness/screen/feedback/bloc/feedback_view_bloc.dart';
import 'package:fitness/screen/feedback/create_feedback_dialog.dart';
import 'package:fitness/utils/date_time_utils.dart';
import 'package:fitness/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({super.key, required this.user});
  final UserModel user;
  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  late FeedbackViewBloc feedbackViewBloc;

  @override
  void initState() {
    feedbackViewBloc = FeedbackViewBloc(userId: widget.user.id ?? '');
    feedbackViewBloc.add(LoadFeedbacks());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => feedbackViewBloc,
      child: BlocBuilder<FeedbackViewBloc, FeedbackViewState>(
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
                                    CreateFeedbackDialog(user: widget.user))
                            .then((value) {
                          if (value != null) {
                            feedbackViewBloc.add(AddNewFeedback(value));
                          }
                        });
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
                      child: const Text('Viết đánh giá')),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: 400,
                    ),
                    child: ListView.separated(
                        itemCount: state.feedbacks.length + 1,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          if (index >= state.feedbacks.length) {
                            if (state.hasMore) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state.feedbacks.isEmpty) {
                              return Center(
                                child: Text('Chưa có đánh giá nào'),
                              );
                            }
                            return Offstage();
                          }
                          return Container(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox.square(
                                      dimension: 40,
                                      child: ClipOval(
                                        child: ImageNetworkCacheCommon(
                                            base64: state.feedbacks[index].user
                                                    ?.avatar ??
                                                ''),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.feedbacks[index].user?.name ??
                                                '',
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          RatingBarIndicator(
                                            itemSize: 12,
                                            direction: Axis.horizontal,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            rating:
                                                state.feedbacks[index].rating ??
                                                    0,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      DateTimeUtils.convertDateTimeToString(
                                          state.feedbacks[index].createdAt ??
                                              DateTime.now()),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(state.feedbacks[index].content ?? ''),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
