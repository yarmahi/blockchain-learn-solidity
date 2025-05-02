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

### 2. Moving Ether
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

### 3. Calling Other Contracts
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

### 4. Simple Safety Checks
- **Non-zero address:** `require(addr != address(0), "Invalid address");`
- **Balance check:** `require(address(this).balance >= amount, "Insufficient funds");`

---

### Key Ideas at a Glance
| Concept         | Why It Matters                                    | Example                            |
| --------------- | ------------------------------------------------- | ---------------------------------- |
| `address` type  | Holds account or contract identifier              | `address user;`                    |
| `payable`      | Allows receiving Ether                            | `address payable wallet;`          |
| `transfer`      | Safely send Ether, auto-reverts on failure        | `wallet.transfer(1 ether);`        |
| Interfaces      | Call external contract functions                  | `ICounter(cnt).increment();`       |
| Safety checks   | Prevent misuse and errors                          | `require(addr!=address(0));`       |

---

