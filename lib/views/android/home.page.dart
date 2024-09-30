import 'package:chat_ai/common/toast.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:chat_ai/controllers/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:chat_ai/views/android/login.page.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Gemini gemini = Gemini.instance;
  final FirebaseAuthService auth = FirebaseAuthService();

  ChatUser currentUser = ChatUser(id: '0', firstName: 'User');
  ChatUser geminiUser = ChatUser(id: '1', firstName: 'Gemini');

  List<ChatMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: MaterialApp(
          theme:
              ThemeData(primaryColor: const Color.fromARGB(255, 174, 123, 196)),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: Colors.grey[850],
            appBar: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 174, 123, 196),
                      Colors.lightBlue
                    ],
                  )),
                ),
                surfaceTintColor: Colors.transparent,
                title: const Text('Chat AI',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
                actions: [
                  GestureDetector(
                    child: MaterialButton(
                      child: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        auth.signOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()),
                          (route) => false,
                        );
                      },
                    ),
                  )
                ]),
            body: buildUi(),
          )),
    );
  }

  Widget buildUi() {
    return DashChat(
      inputOptions: InputOptions(
          textCapitalization: TextCapitalization.sentences,
          inputTextStyle: const TextStyle(
              color: Colors.white, decorationColor: Colors.transparent),
          cursorStyle:
              const CursorStyle(color: Color.fromARGB(255, 174, 123, 196)),
          alwaysShowSend: false,
          sendOnEnter: true,
          inputDecoration: InputDecoration(
              hintText: 'Digite um comando...',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
              filled: true,
              fillColor: Colors.grey[900],
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 174, 123, 196)),
                  borderRadius: BorderRadius.circular(10)))),
      currentUser: currentUser,
      onSend: sendMessage,
      messages: messages,
      messageOptions: const MessageOptions(
        currentUserContainerColor: Colors.lightBlue,
        containerColor: Color.fromARGB(255, 174, 123, 196),
        textColor: Colors.white,
        borderRadius: 10,
      ),
    );
  }

  void sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      gemini.streamGenerateContent(question).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  '', (previous, current) => '$previous ${current.text}') ??
              '';
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold(
                  '', (previous, current) => '$previous ${current.text}') ??
              '';
          ChatMessage message = ChatMessage(
              user: geminiUser, createdAt: DateTime.now(), text: response);
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      showToast(message: 'Ocorreu um erro: $e');
    }
  }
}
