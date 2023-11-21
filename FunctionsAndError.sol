// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Account {
    struct AccountInfo {
        string name;
        address accountAddress;
    }
    uint public balance; 
    uint public constant MAX_BALANCE = 1000; 

    mapping(address => AccountInfo) public accounts; 

    function createAccount(string memory name) public {
        address accountAddress = msg.sender;
        
        require(bytes(accounts[accountAddress].name).length == 0, "Account already exists");
        
        accounts[accountAddress] = AccountInfo(name, accountAddress);
    }

    function deposit(uint amount) public {
        uint oldBalance = balance;
        uint newBalance = balance + amount;

        require(newBalance <= MAX_BALANCE, "Transaction exceeds the max balance limit");

        balance = newBalance;

        assert(balance >= oldBalance);
    }

    function withdraw(uint amount) public {
        uint oldBalance = balance;

        require(MAX_BALANCE >= amount, "Transaction exceeds the max balance limit");

        if (balance < amount) {
            revert("Insufficient balance");
        }

        balance -= amount;

        assert(balance <= oldBalance);
    }
}
