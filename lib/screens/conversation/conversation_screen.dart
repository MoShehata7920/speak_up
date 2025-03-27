import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:speak_up/manager/conversation/conversation_cubit.dart';
import 'package:speak_up/resources/assets_manager.dart';
import 'package:speak_up/resources/icons_manager.dart';
import 'package:speak_up/resources/strings_manager.dart';
import 'package:speak_up/widgets/app_text.dart';

class ConversationScreen extends StatelessWidget {
  const ConversationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConversationCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: AppText(
            text: AppStrings.aiConversation.tr(),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Column(
          children: [
            Expanded(child: _buildMessageList()),
            _buildTypingIndicator(),
            _buildMessageInput(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageList() {
    return BlocBuilder<ConversationCubit, List<Map<String, dynamic>>>(
      builder: (context, messages) {
        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: messages.length,
          itemBuilder: (context, index) {
            final message = messages[index];
            return _buildMessageBubble(message["text"], message["isUser"]);
          },
        );
      },
    );
  }

  Widget _buildMessageBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: 300),
        decoration: BoxDecoration(
          color: isUser ? Colors.blueAccent : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: AppText(
          text: text,
          color: isUser ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return BlocBuilder<ConversationCubit, List<Map<String, dynamic>>>(
      builder: (context, messages) {
        final cubit = context.read<ConversationCubit>();
        return cubit.isTyping
            ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Lottie.asset(AppJson.typingIndicator, height: 30),
            )
            : const SizedBox();
      },
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: AppStrings.typeAMessage.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(AppIcons.mic, color: Colors.blueAccent),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(AppIcons.send, color: Colors.blueAccent),
            onPressed: () {
              context.read<ConversationCubit>().sendMessage(
                messageController.text,
              );
              messageController.clear();
            },
          ),
        ],
      ),
    );
  }
}
