import 'package:echo/model/chat.dart';
import 'package:echo/model/receiver_messages.dart';
import 'package:echo/utils/app_singleton.dart';

extension Dates on DateTime {
  String get formatDateTime {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    if (year == now.year && month == now.month && day == now.day) {
      // Format for today (HH:mm AM/PM)
      String h = hour % 12 == 0 ? '12' : (hour % 12).toString();
      String m = minute.toString().padLeft(2, '0');
      String amPm = hour < 12 || hour == 24 ? 'AM' : 'PM';
      return '$h:$m $amPm';
    } else if (year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day) {
      return 'Yesterday';
    } else {
      // Format for other dates (MM/DD/YYYY)
      String m = month.toString().padLeft(2, '0');
      String d = day.toString().padLeft(2, '0');
      return '$m/$d/$year';
    }
  }
}

extension Converter on List<Chat> {
  List<ReceiverMessages> get convertChatsToReceiverMessages {
    final Map<String, List<Chat>> groupedChats = {};
    String ownerId = "${AppSingleton.instance.user?.id}";
    for (final chat in this) {
      final receiver = chat.receiver;
      final sender = chat.sender;
      final key = (ownerId == sender) ? receiver : sender;
      groupedChats.putIfAbsent(key, () => []);
      groupedChats[key]?.add(chat);
    }

    return groupedChats.entries.map((entry) {
      final receiver = entry.key;
      final messages = entry.value;
      messages.sort((a, b) => b.dateTime.compareTo(a.dateTime)); // Sort by date
      final lastMessage = messages.first; // Get the last message

      return ReceiverMessages(
        receiver: receiver,
        messages: messages,
        lastMessage: lastMessage,
      );
    }).toList();
  }

  List<Chat> get unreadMessages => where((chat) =>
      chat.receiver == AppSingleton.instance.user?.id && !chat.isRead).toList();
  List<Chat> get unDeliveredMessages => where((chat) =>
      chat.receiver == AppSingleton.instance.user?.id && !chat.isRead).toList();
}
