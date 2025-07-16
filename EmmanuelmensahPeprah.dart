
// Imports the 'dart:io' library, which provides functionality for input/output operations, like reading from the console.
import 'dart:io'; 

void main() {
  // Prompts the user to enter their name.
  print('Please enter your name:');

  // Reads a line of input from the console.
  // stdin.readLineSync() returns a nullable String (String?) because the user might not enter anything.
  String? name = stdin.readLineSync();

  // Checks if the 'name' variable is not null AND not empty.
  if (name != null && name.isNotEmpty) {
    // If a name is entered, it prints a personalized welcome message.
    print('Hello, $name! Welcome to your Dart programming journey.');
  } else {
    // If no name is entered (or if it's empty), it prints a generic welcome message.
    print('Hello, world! Welcome to your Dart programming journey.');
 }
}

