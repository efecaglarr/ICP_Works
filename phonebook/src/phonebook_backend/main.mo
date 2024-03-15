// actor -> canister -> smart contract

import Map "mo:base/HashMap";
import Text "mo:base/Text";

actor {

  type Name = Text;
  type Phone = Text;
  type Address = Text;

  type Entry = {
    description: Text;
    phone: Phone;
    address: Address;
  };

  var phoneBook = Map.HashMap< Name, Entry >(0, Text.equal, Text.hash);

  // query -> sorgu fonksiyonu
  // update -> güncelleme fonksiyonu

  public func insert(name : Name, entry: Entry) : async () {
    phoneBook.put(name, entry);
  };

  public query func find(name : Name) : async ?Entry {
    phoneBook.get(name); // return phoneBook.get(name).
  };

}