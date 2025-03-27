import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import 'package:speak_up/manager/ai_chat/ai_chat_cubit.dart';
import 'package:speak_up/manager/ai_chat/ai_chat_state.dart';
import 'package:speak_up/models/chat_message_model.dart';
import 'package:speak_up/resources/assets_manager.dart';
import 'package:speak_up/resources/icons_manager.dart';
import 'package:speak_up/resources/strings_manager.dart';
import 'package:speak_up/widgets/app_text.dart';

class AiChatScreen extends StatelessWidget {
  AiChatScreen({super.key});
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AiChatCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: AppText(
            text: AppStrings.aiChat.tr(),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<AiChatCubit, AiChatState>(
                builder: (context, state) {
                  final messages =
                      state is AiChatMessageUpdated ? state.messages : [];

                  return ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessageBubble(context, messages[index]);
                    },
                  );
                },
              ),
            ),
            BlocBuilder<AiChatCubit, AiChatState>(
              builder: (context, state) {
                if (state is AiChatTyping) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Lottie.asset(AppJson.typingIndicator, height: 30),
                  );
                }
                return const SizedBox();
              },
            ),
            _buildMessageInput(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(BuildContext context, ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blueAccent : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(16),
        ),
        child: AppText(
          text: message.message,
          color: message.isUser ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildMessageInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: AppStrings.askAiAnything.tr(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 15),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(AppIcons.regenerate, color: Colors.orange),
            onPressed: () {
              context.read<AiChatCubit>().regenerateResponse();
            },
          ),
          IconButton(
            icon: const Icon(AppIcons.send, color: Colors.blueAccent),
            onPressed: () {
              context.read<AiChatCubit>().sendMessage(messageController.text);
              messageController.clear();
            },
          ),
        ],
      ),
    );
  }
}
