import 'package:flutter/material.dart';

// a MessageBubble for showing a single chat message on the ChatScreen
class MessageBubble extends StatelessWidget {

  // create a message bubble which is meant to be the first in the sequence
  const MessageBubble.first({
    super.key,
    required this.userImage,
    required this.username,
    required this.message,
    required this.isMe,
  }) : isFirstInSequence = true;

  // create a amessage bubble that continues the sequence
  const MessageBubble.next({
    super.key,
    required this.message,
    required this.isMe,
  })  : isFirstInSequence = false,
        userImage = null,
        username = null;

  // whether or not this message bubble is the first in a sequence of messages from the same user
  // modifies the message bubble slightly for these different cases - only
  // shows user image for the first message from the same user, and changes
  // the shape of the bubble for messages thereafter
  final bool isFirstInSequence;

  // not required if the message is not the first in a sequence
  final String? userImage;

  // Not required if the message is not the first in a sequence.
  final String? username;
  final String message;

  // Controls how the MessageBubble will be aligned.
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        if (userImage != null)
          Positioned(
            top: 15,
            // Align user image to the right, if the message is from me
            right: isMe ? 0 : null,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                userImage!,
              ),
              backgroundColor: theme.colorScheme.primary.withAlpha(180),
              radius: 23,
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 46),
          child: Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  // first messages in the sequence provide a visual buffer at the top.
                  if (isFirstInSequence) const SizedBox(height: 18),
                  if (username != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 13,
                        right: 13,
                      ),
                      child: Text(
                        username!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),

                  // the "speech" box surrounding the message
                  Container(
                    decoration: BoxDecoration(
                      color: isMe
                          ? Colors.grey[300]
                          : theme.colorScheme.secondary.withAlpha(200),
                      // only show the message bubble's "speaking edge" if first is the chain
                      // whether the "speaking edge" is on the left or right depends on whether or not the message bubble is the current user
                      borderRadius: BorderRadius.only(
                        topLeft: !isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(12),
                        topRight: isMe && isFirstInSequence
                            ? Radius.zero
                            : const Radius.circular(12),
                        bottomLeft: const Radius.circular(12),
                        bottomRight: const Radius.circular(12),
                      ),
                    ),
                    constraints: const BoxConstraints(maxWidth: 200),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    child: Text(
                      message,
                      style: TextStyle(
                        height: 1.3,
                        color: isMe
                            ? Colors.black87
                            : theme.colorScheme.onSecondary,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}