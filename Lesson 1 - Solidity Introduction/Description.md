## Introduction to Solidity 

This is the first module in the **Learn Solidity** course by Alchemy. Here, we get familiar with Solidity, the language used to build smart contracts on the Ethereum network.

### What This Module Covers
1. Understanding what Solidity is and why we use it.
2. Setting up a development environment.
3. Writing and deploying a simple smart contract.
4. Key building blocks of a Solidity contract.

---

### 1. What Is Solidity?
Solidity is a programming language for creating smart contracts on Ethereum. It borrows ideas from C++, Python, and JavaScript. Because it’s _statically typed_, you must declare the type of each variable.Many blockchains besides Ethereum (EVM-compatible chains) accept Solidity contracts.

### 2. Preparing Your Tools
To write and test contracts, we use Remix IDE:
- It runs in your browser.
- No installation needed.
- Lets you compile and deploy contracts quickly.


---
### 3. Deployment
Steps
 - Compile Solidity code into bytecode.
 - Send the bytecode in a transaction to an EVM node.
 - Node calculates and assigns a new contract address.
 

### Deployment Details
 - Sending bytecode in the data field of a transaction.
 - Leaving the to field empty (signals deployment).
 - The blockchain assigns a home address for the contract.
 - Contracts can have an initial Ether balance if specified; otherwise, default is 0 Ether.

 ---

### 4. Your First Smart Contract
We built a **Storage** contract that can hold one number:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Storage {
    uint256 number; // holds our value

    // Store a new value
    function store(uint256 _num) external {
        number = _num;
    }

    // Read the stored value
    function retrieve() external view returns (uint256) {
        return number;
    }
}
```


- **State Variable**: `number` lives on the blockchain.
- **Functions**:
  - `store`: writes data.
  - `retrieve`: reads data without changing it.
- **Visibility**: `external` means only outside callers can use these functions.

---

### 5. Storage Slots
- Variable stored in contract scope allocate storage slot(except for constant)
- Slots are 32 bytes (0x1 means 0x000000......1)
- Solidity stores variable contiguously (0x0,0x1,0x2...etc)
- Reading/writing to storage is relatively expensive to other opcodes
  
|Opcode  |	Name	|      Description	          | Gas |
|--------|----------|-----------------------------|-----|
| 0x00	 |STOP	    |  Halts execution	          |  0  |
| 0x01	 |ADD	    | Addition operation          |  3  |
| 0x02	 |MUL	    | Multiplication operation	  |  5  |
| 0x03	 |SUB	    | Subtraction operation	      |  3  |

OP Codes and Gas
 - OP Codes: Low-level operations the EVM can perform.
 - Compilation turns high-level Solidity into sequences of OP codes.
 - Example:
 - Adding two integers → ADD OP code used.
 - Solidity compiles to OP codes (e.g., ADD).

Gas and Payment
 - Every OP code consumes a specific amount of gas (e.g., ADD = 3 gas units).
 - Gas is a computational unit, paid in the blockchain’s native currency (e.g., Ether for Ethereum).
 - Gas price fluctuates based on network traffic (“market price”).
 - Gas used depends on the computation, while cost of gas depends on the market rate.
  
 ---
 
  ```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Storage {
    uint256 a = 100; // storage slot 0X0
    bool c = true; // storage slot 0X1

    constructor() {
        console.log(a);
    }

}
```
  
### 6. Visibility keys on function
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Example {
    function example1() private pure{
     //private : Call me within this contract
     //pure : I can not read or write in this storage
    }
    function example2() internal view{
     //internal : Call me within this contract(+ inheritance)
     //view : I can read from storage not write
    }
    function example3() public payable{
     //public : Call me insisde and outside this contract
     //payable : Send me some either
    }
    function example4() external {
     //external : Call me from outside this contract
    }

 }

```

### 7. Core Ideas
| Concept               | Why It Matters                                    | Example           |
|-----------------------|---------------------------------------------------|-------------------|
| State Variables       | Persist data on-chain                            | `uint256 number`  |
| Data Types            | Define what kind of data you work with            | `bool`, `address` |
| Visibility Modifiers  | Control who can call functions or see variables   | `public`, `private` |
| Events                | Let contracts emit logs for off-chain listeners   | `event Stored(uint256)` |
| Function Modifiers    | Reuse code before/after function runs (e.g., auth) | `modifier onlyOwner` |

---

