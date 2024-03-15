import Map "mo:base/HashMap";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Text "mo:base/Text";
import Bool "mo:base/Bool";

actor {
  type ToDo = {
    description: Text;
    completed: Bool;
  };
  
  func natHash (n : Nat) : Hash.Hash {
    Text.hash(Nat.toText(n))
  };

  var todos = Map.HashMap<Nat, ToDo>(0, Nat.equal, natHash);
  var nextId: Nat = 0;

  public query func getTodos() : async [ToDo] {
    Iter.toArray(todos.vals());
  };

  public func addTodo(description: Text) : async Nat {
    let id = nextId;
    todos.put(id, { description = description; completed = false });
    nextId += 1;
    id;
  };

  public func completeTodo(id: Nat) : async () {
    ignore do ? {
      let description = todos.get(id)!.description;
      todos.put(id, { description; completed = true})
    }
  };

  public query func showTodos() : async Text {
    var output: Text = "________TO-DOs________";
    for (todo: ToDo in todos.vals()) {
      output #= "\n" # todo.description;
      if (todo.completed) { output #= "\n" # " +"};
    };
    output # "\n";
  };

  public func clearCompleted() : async () {
    todos := Map.mapFilter<Nat, ToDo, ToDo>(todos, Nat.equal, natHash, func(_, todo) { if (todo.completed) null else ?todo });
    // Nat.equal -> checks if two natural numbers are equal when comparing map keys.
    // The first ToDo -> specifies the type of objects in the array.
    // The second ToDo -> represents the filtered result of our map operation.
    // natHash -> computes a hash value for each natural number key
  };
}