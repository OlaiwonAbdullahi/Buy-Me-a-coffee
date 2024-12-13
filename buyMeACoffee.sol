
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract BuyMeACoffee {

    event NewMemo(address indexed  from, uint256 timestamp, string name, uint256 amount, string message);

    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        uint256 amount;
        string message;
    }


    // want to difine an owner which own the coffee because in this case this payable is a data type
    address payable public owner;

    // in this point is just that i am declearing the data type which is Memo
    Memo[] memos;

    modifier  ownerOnly() {
        require(msg.sender == owner, "Not the owner");

        _;
    }

    constructor () {
        owner = payable (msg.sender);
    }

    // Is to define our function
   function buCoffee(string memory _name, string memory _message) public payable {
    require(msg.value > 0, "Cannot buy coffee for free");

    memos.push(Memo(msg.sender, block.timestamp, _name, msg.value, _message));

    emit NewMemo(msg.sender, block.timestamp, _name, msg.value, _message);
   }

  function withdrawTips() public {
    (bool success, ) = owner.call{value: address(this).balance}("");

    require(success, "Transfer failed");
  }

  
   function getMemos() public view returns (Memo[] memory){
    return memos;    
   }

    
}
