}

class ChatsScreen extends StatelessWidget {
  final String user;
  const ChatsScreen({super.key, required this.user});

  static const chats = [
    ['Алекс', 'Привет! Как дела?'],
    ['Мария', 'Увидимся вечером'],
    ['Команда', 'Новая версия готова'],
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Чаты · $user')),
        body: ListView.separated(
          itemCount: chats.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, i) => ListTile(
            leading: CircleAvatar(child: Text(chats[i][0][0])),
            title: Text(chats[i][0]),
            subtitle: Text(chats[i][1]),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ChatScreen(title: chats[i][0])),
            ),
          ),
        ),
      );
}

class Msg {
  final String text;
  final bool mine;
  Msg(this.text, this.mine);
}

class ChatScreen extends StatefulWidget {
  final String title;
  const ChatScreen({super.key, required this.title});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ctrl = TextEditingController();
  final List<Msg> messages = [Msg('Привет!', false)];

  void send() {
    final t = ctrl.text.trim();
    if (t.isEmpty) return;
    setState(() => messages.add(Msg(t, true)));
    ctrl.clear();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: messages.length,
                itemBuilder: (_, i) {
                  final m = messages[i];
                  return Align(
                    alignment:
                        m.mine ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: m.mine ? Colors.blue : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(m.text,
                          style: TextStyle(
                              color: m.mine ? Colors.white : Colors.black87)),
                    ),
                  );
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: ctrl,
                        onSubmitted: (_) => send(),
                        decoration: const InputDecoration(
                            hintText: 'Сообщение',
                            border: OutlineInputBorder()),
                      ),
                    ),
                    IconButton(
                        onPressed: send,
                        icon: const Icon(Icons.send, color: Colors.blue)),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
