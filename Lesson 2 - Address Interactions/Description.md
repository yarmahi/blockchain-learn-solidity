## Working with Addresses in Solidity

This module shows how smart contracts use and interact with Ethereum addresses.

### What You'll Do
1. Learn what an Ethereum address is and why it matters.
2. Send and receive Ether in contracts.
3. Call functions on other contracts by address.
4. Apply simple checks to keep address use safe.

---

### 1. Ethereum Addresses 101

- **Structure:** A 20-byte value, written as a hexadecimal string (e.g. `0xabc...`).
- **Usage:** Identifies accounts and contracts on Ethereum.
- **In Solidity:** Use the `address` type to store these values.

---

### 2. Message Calls

- Send value and calldata to contracts
- The first message call is the beginning of the transaction (EOA -> contract)
- Each subsequent message call is part of the same transaction (contract -> contract)
- The transaction and any state changes only complete when the initial function call finishes execution

---
### Message Call Breakdown
- As i saw message calls can contain gas, value and calldata.
- These message values become available as globals in solidity:
- `msg.sender` - who made the last message call
- `msg.value` - amount in wei sent
- `msg.data` - calldata
- `msg.sig` - the function identifier
  
---
### How Do EOAs and Contracts Call Other Contracts?
- They use the address of the contract they want to communicate with
- This is a data type in solidity that is 20 bytes long
- The msg.sender from the previous slide is an address
  
---


### Moving Ether

```solidity
address payable recipient = payable(0x123...);

// Send 1 ether
recipient.transfer(1 ether);

// Or use send (returns success flag)
bool success = recipient.send(1 ether);
require(success, "Send failed");
```
- **transfer:** Reverts on failure.
- **send:** Returns `false` on failure—handle with `require`.

---

### 3. Revert

- We talk to a contract with message calls
- A contract can REVERT a call, negating all state changes
- Each calling contract can choose to handle that success, or REVERT as well
---

### Message Call Revert

- No state changes occur
- No value is transfered
- No logs are emitted
- Gas is still spent
---
### Revert

Revert can be used with a string revert("Unauthorized") or, better yet:

```solidity
contract X {
  // @notice a non-privileged user attempted to access an admin-only method
  error Unauthorized();

  function adminOnly() external {
    if (!isAdmin(msg.sender)) {
      revert Unauthorized();
    }
  }
}
```
---
### 4. Calldata (How to Target Functions!)

- It's helpful to remember that Solidity's job is to compile contracts into bytecode.
- Solidity doesn't know anything about the blockchain it's deployed on.
- If you tell Solidity to call an `address` with calldata, it will do exactly that.
- You can do this using both high-level and low-level syntax.
  
---

###  Calling Other Contracts
```solidity
interface ICounter { function increment() external; }

function callIncrement(address counterAddr) external {
    ICounter(counterAddr).increment();
}
```
- Define an **interface** matching the target contract.
- Cast the address to that interface.
- Call its functions directly.

---

### 5. Simple Safety Checks
- **Non-zero address:** `require(addr != address(0), "Invalid address");`
- **Balance check:** `require(address(this).balance >= amount, "Insufficient funds");`

---

### Key Ideas at a Glance
| Concept         | Why It Matters                                    | Example                            |
| --------------- | ------------------------------------------------- | ---------------------------------- |
| `address` type  | Holds account or contract identifier              | `address user;`                    |
| `payable`       | Allows receiving Ether                            | `address payable wallet;`          |
| `transfer`      | Safely send Ether, auto-reverts on failure        | `wallet.transfer(1 ether);`        |
| Interfaces      | Call external contract functions                  | `ICounter(cnt).increment();`       |
| Safety checks   | Prevent misuse and errors                         | `require(addr!=address(0));`       |

---

