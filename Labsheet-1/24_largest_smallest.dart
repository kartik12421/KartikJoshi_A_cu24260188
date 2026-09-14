void main() {
  List<int> numbers = [10, 5, 30, 2, 20];

  int largest = numbers[0];
  int smallest = numbers[0];

  for (int n in numbers) {
    if (n > largest) largest = n;
    if (n < smallest) smallest = n;
  }

  print("Largest: $largest");
  print("Smallest: $smallest");
}
