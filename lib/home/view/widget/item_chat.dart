import 'package:chatapp/chat/chat_screen.dart';
import 'package:chatapp/home/model/chat_item_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/theme_extension.dart';

class ItemChat extends StatelessWidget {
  const ItemChat({super.key, required this.chatItemModel});
  final ChatItemModel chatItemModel;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textStyles = context.textStyles;

    final hasMessage = chatItemModel.message.isNotEmpty;
    final lastMessage =
        hasMessage ? chatItemModel.message.last.text.toString() : "No messages yet";
    final timeStr = hasMessage
        ? DateFormat('h:mm a').format(
            DateTime.parse(chatItemModel.message.last.time ?? ""))
        : "";

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.primaryBorder.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          highlightColor: colors.primary.withValues(alpha: 0.1),
          splashColor: colors.secondary.withValues(alpha: 0.1),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  chatId: chatItemModel.id,
                  otherUserName: chatItemModel.name ?? "",
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: colors.primaryGradient,
                  ),
                  child: CircleAvatar(
                    radius: 26,
                    backgroundColor: colors.surface,
                    backgroundImage: NetworkImage(
                      (chatItemModel.image == null || chatItemModel.image!.isEmpty)
                          ? "https://cdn-icons-png.flaticon.com/512/149/149071.png"
                          : chatItemModel.image!,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              chatItemModel.name ?? "Unknown",
                              style: textStyles.textButtonPrimary.copyWith(
                                color: colors.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (timeStr.isNotEmpty)
                            Text(
                              timeStr,
                              style: textStyles.chatTimeText,
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        lastMessage,
                        style: textStyles.labelText.copyWith(
                          color: hasMessage
                              ? colors.textSecondary
                              : colors.primary.withValues(alpha: 0.7),
                          fontStyle:
                              hasMessage ? FontStyle.normal : FontStyle.italic,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
