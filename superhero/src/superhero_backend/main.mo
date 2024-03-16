import List "mo:base/List";
import Option "mo:base/Option";
import Trie "mo:base/Trie";
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";

actor {

  public type SuperHeroId = Nat32;

  public type SuperHeroType = {
    name: Text;
    superpowers: List.List<Text>;
    };

  private stable var next: SuperHeroId = 0;

  private stable var superheroes: Trie.Trie<SuperHeroId, SuperHeroType> = Trie.empty();

  // advanced level API.

  public func create(superhero: SuperHeroType): async SuperHeroId {
    let superheroId = next;
    next += 1;
    superheroes := Trie.replace(
      superheroes,
      key(superheroId),
      Nat32.equal,
      ?superhero,
    ).0;
    superheroId
  };

  public func read(superheroId: SuperHeroId) : async ?SuperHeroType {
    let result = Trie.find(superheroes, key(superheroId), Nat32.equal);
    result;
  };

  public func update(superheroId: SuperHeroId, superhero: SuperHeroType) : async Bool {
    let result = Trie.find(superheroes, key(superheroId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      superheroes := Trie.replace(
        superheroes, 
        key(superheroId),
        Nat32.equal,
        ?superhero,
        ).0;
  };
  exists;
  };

  public func delete(superheroId: SuperHeroId) : async Bool {
    let result = Trie.find(superheroes, key(superheroId), Nat32.equal);
    let exists = Option.isSome(result);
    if (exists) {
      superheroes := Trie.replace(
        superheroes, 
        key(superheroId),
        Nat32.equal,
        null,
        ).0;
    };
    exists;
  };

  private func key(x: SuperHeroId) : Trie.Key<SuperHeroId> {
    { hash = x; key = x};
  }
};