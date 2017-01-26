pragma solidity ^0.4.4;


import "../ownership/Ownable.sol";


contract Order is Ownable {

  address public owner;
  address public buyer;
  uint public orderPrice;
  string public orderproducts;
  string public stateMessage;
  string public message;
  string public orderBlock;
  string public orderStatus;
  uint public stateInt;

  function Order(address _buyer) {
    owner = msg.sender;
    buyer = _buyer;

    stateMessage = "Created New Order";
    stateInt = 1;

    message = stateMessage;
  }

  function setUpOrderDetails(uint price, string products, string block, string status) {
    stateMessage = "Order details set";
    message = stateMessage;
    stateInt = 2;
    orderPrice = price;
    orderProducts = products;
	  orderBlock = block;
	  orderStatus = status;
	
  }

  function refundToBuyer() {
    if(msg.sender == owner) {
      buyer.send(this.balance);
  }


  function getBalance() constant returns (uint) {
    return this.balance:
  }

}

}