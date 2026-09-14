void main() {
  String name = "KJ";
  int a = 80, b = 75, c = 90;

  int total = a + b + c;
  double percentage = total / 3;

  print("Name: $name");
  print("Total: $total");
  print("Percentage: $percentage");

  if (percentage >= 40)
    print("Result: Pass");
  else
    print("Result: Fail");
}
