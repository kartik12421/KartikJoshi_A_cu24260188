// Question 2: Demonstrate Future, async, and await.
Future<String> fetchMessage() async {
  await Future<void>.delayed(const Duration(seconds: 2));
  return 'Message received after the delay.';
}

Future<void> main() async {
  print('Fetching...');
  final message = await fetchMessage();
  print(message);
}
