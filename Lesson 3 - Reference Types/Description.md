## Reference Types in Solidity 

This module covers Solidity's reference types, which let you handle complex data and dynamic memory.

### Goals
1. Learn how Solidity stores and manages arrays, structs, strings, and mappings.
2. See differences between reference and value types.
3. Apply best practices to avoid memory and gas issues.

---

### 1. Value vs. Reference
- **Value types** (e.g., `uint`, `bool`): stored directly.
- **Reference types** (e.g., arrays, structs, mappings, string): store a pointer to data in memory or storage.

---

### 2. Arrays & Structs
```solidity
struct Person { string name; uint age; }
Person[] public people;

function addPerson(string memory _name, uint _age) external {
    people.push(Person(_name, _age));
}
```
- **Storage arrays**: persist on-chain.
- **Memory arrays**: temporary, cheaper to use in functions.

---

### 3. Strings
```solidity
function concat(string memory a, string memory b) external pure returns (string memory) {
    return string(abi.encodePacked(a, b));
}
```
- Strings are reference types.
- Use `memory` for function parameters.
- `abi.encodePacked` to join strings.

---

### 4. Mappings
```solidity
mapping(address => uint) public balances;

function deposit() external payable {
    balances[msg.sender] += msg.value;
}
```
- Key-value store.
- Default value if key missing.

---


