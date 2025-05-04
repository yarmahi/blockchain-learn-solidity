## Applied Solidity 

In this lesson, we apply Solidity knowledge to build practical dApps and contract systems.

### What You’ll Build
1. A simple on-chain voting system.
2. Contracts that use inheritance for reusable code.

---

### 1. Decentralized Voting
```solidity
contract Voting {
    mapping(address => bool) public voted;
    mapping(bytes32 => uint) public votes;
    bytes32[] public candidates;

    constructor(bytes32[] memory _candidates) {
        candidates = _candidates;
    }

    function vote(bytes32 candidate) external {
        require(!voted[msg.sender], "Already voted");
        votes[candidate] += 1;
        voted[msg.sender] = true;
    }

    function totalVotes(bytes32 candidate) external view returns (uint) {
        return votes[candidate];
    }
}
```
- Tracks who voted.
- Counts votes per candidate.
- Prevents double voting.

---

### 2. Inheritance for Reuse
```solidity
contract Ownable {
    address public owner;
    constructor() { owner = msg.sender; }
    modifier onlyOwner() { require(msg.sender==owner, "Not owner"); _; }
}

contract MyToken is Ownable {
    mapping(address=>uint) public balance;
    function mint(address to, uint amt) external onlyOwner {
        balance[to]+=amt;
    }
}
```
- **Ownable**: base for access control.
- **onlyOwner**: reuse in child contracts.

---

