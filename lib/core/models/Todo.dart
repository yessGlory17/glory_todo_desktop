import 'dart:math';

class Todo {
  String columnUnicId;
  String todo;
  bool isCheck = false;
  String todoId;
  var rand = new Random();
  Todo(this.columnUnicId, this.todo) {}

  //Dosyaya yazılırken bu kullanılacak. Dosyadan çağrılırken diğeri kullanılacak.
  Todo.withId(this.columnUnicId, this.todo) {
    todoId = rand.nextInt(1000000 - 10000).toString();
  }
}
