import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async'; // For exponential backoff

// --- Data Model for a Chat Message ---
class ChatMessage {
  final String text;
  final bool isUser;
  ChatMessage({required this.text, required this.isUser});
}

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  // --- State Variables ---
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _isLoading = false;

  //
  // -------------------------------------------------------------------------
  // --- 1. GET YOUR FREE API KEY ---
  //
  // Go to Google AI Studio (aistudio.google.com)
  // 1. Sign in with your Google account.
  // 2. Click "Get API key" and create a new key.
  // 3. Paste that key here.
  //
  // --- IMPORTANT: DO NOT SHARE THIS KEY OR PUSH IT TO GITHUB ---
  //
  final String _apiKey = "API_KEY";
  // -------------------------------------------------------------------------
  //

  @override
  void initState() {
    super.initState();
    // Add a welcome message from the bot
    _messages.add(
      ChatMessage(
        text:
            "Hello! I am HydoBot. How can I help you with your water-related questions today?",
        isUser: false,
      ),
    );
  }

  /// Scrolls the chat list to the bottom
  void _scrollToBottom() {
    // Add a small delay to ensure the UI has time to update
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// Sends the user's message to the Gemini API
  Future<void> _sendMessage() async {
    final text = _controller.text;
    if (text.trim().isEmpty) return;

    // Add user message to the list
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true));
      _isLoading = true;
    });

    _controller.clear();
    _scrollToBottom();

    // --- 2. Call the Gemini API ---
    try {
      await _callGeminiAPI(text);
    } catch (e) {
      // Handle API call errors
      _addBotResponse(
        "Sorry, I'm having trouble connecting. Please try again later.",
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
      _scrollToBottom();
    }
  }

  /// Adds a response from the bot to the chat list
  void _addBotResponse(String text) {
    setState(() {
      _messages.add(ChatMessage(text: text, isUser: false));
    });
  }

  /// Handles the actual API request with exponential backoff
  Future<void> _callGeminiAPI(
    String userQuery, {
    int retries = 3,
    Duration delay = const Duration(seconds: 2),
  }) async {
    //
    // --- 3. THE CUSTOMIZATION PROMPT ---
    // This "systemInstruction" forces the AI to only talk about water.
    //
    const String systemPrompt = """
    You are 'HydroBot', a friendly and knowledgeable AI assistant.
    Your sole and exclusive purpose is to provide information and answer questions related to the theme of WATER.

    Your areas of expertise are:
    - Water Harvesting: Rainwater harvesting, check dams, ponds, etc.
    - Water Conservation: Tips for saving water at home, in agriculture, and in industry.
    - Water Purification: Methods like RO, UV, boiling, sand filters, and traditional techniques.
    - Water Knowledge: The water cycle, properties of water, the global water crisis.
    - Community Awareness: Ideas for water-saving campaigns, community projects.

    RULES:
    1. You MUST NOT answer any questions that are unrelated to water.
    2. If a user asks about politics, sports, history, math, coding, or any other off-topic subject, you MUST politely decline.
    3. Example refusal: "As AquaGuide, my focus is entirely on water. I can't answer questions about that topic, but I'd be happy to discuss water purification!"
    4. Be friendly, helpful, and concise.
    """;

    // --- 4. Prepare the API request ---
    final url = Uri.parse(
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-preview-09-2025:generateContent?key=$_apiKey",
    );

    // We only send the *current* query. For a full conversation, you'd send the
    // entire chat history in the "contents" array.
    final payload = {
      "contents": [
        {
          "parts": [
            {"text": userQuery},
          ],
        },
      ],
      "systemInstruction": {
        "parts": [
          {"text": systemPrompt},
        ],
      },
      "generationConfig": {"temperature": 0.7, "topK": 1, "topP": 1},
    };

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: json.encode(payload),
          )
          .timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // --- 5. Extract and display the response ---
        // Check for safety ratings or blocks first
        if (data['candidates'] == null || data['candidates'].isEmpty) {
          _addBotResponse(
            "I'm sorry, I couldn't generate a response for that. Please try a different question.",
          );
          return;
        }

        final modelResponse =
            data['candidates'][0]['content']['parts'][0]['text'];
        _addBotResponse(modelResponse);
      } else {
        // Handle non-200 responses
        if (retries > 0 &&
            (response.statusCode == 503 || response.statusCode == 429)) {
          // Retry with backoff for server errors or rate limiting
          await Future.delayed(delay);
          await _callGeminiAPI(
            userQuery,
            retries: retries - 1,
            delay: delay * 2,
          );
        } else {
          _addBotResponse("Error: ${response.statusCode} - ${response.body}");
        }
      }
    } on TimeoutException {
      _addBotResponse("The request timed out. Please try again.");
    } catch (e) {
      if (retries > 0) {
        // Retry for general network errors
        await Future.delayed(delay);
        await _callGeminiAPI(userQuery, retries: retries - 1, delay: delay * 2);
      } else {
        _addBotResponse("Error: $e");
      }
    }
  }

  // --- 6. Build the UI ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HydroBot 🤖"),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildChatBubble(message);
              },
            ),
          ),

          if (_isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),

          _buildTextInputArea(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage message) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blue.shade100 : Colors.grey.shade500,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Text(
          message.text,
          style: const TextStyle(fontSize: 16.0, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildTextInputArea() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (value) => _sendMessage(),
              decoration: const InputDecoration(
                hintText: "Ask about water conservation...",
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue.shade700),
            onPressed: _isLoading ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
