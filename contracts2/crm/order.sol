pragma solidity ^0.4.9;


import "Ownable.sol";


contract Order is Ownable {

  event OrderActivated(uint _OrderActivatedState);
  event OrderCancelled(uint _OrderCancelledState);

  address public owner;
  address public buyer;
  uint public orderAmount;
  uint public orderActivationBlock;
  string public stateMessage;
  string public message;
  string public orderBlock;
  uint public stateInt;

  function Order(address _buyer) {
    owner = msg.sender;
    buyer = _buyer;

    stateMessage = "Created New Order";
    stateInt = 1;

    message = stateMessage;
  }

  function setUpOrderDetails(uint block_, uint amount_) {
    stateMessage = "Order details set";
    message = stateMessage;
    stateInt = 2;
    orderAmount = amount_;
    orderActivationBlock = block_;
  
  }

  function activateOrder() external returns (bool success){
  if (block.number >= orderActivationBlock) {
  stateMessage = "Order Activated";
  message = stateMessage;
  stateInt = 3;
  }
  if (msg.sender != owner) throw;

  //OrderActivated(uint _OrderActivatedState)

  return true;
  }
    function cancelOrder() external returns (bool success){
  stateMessage = "Order Cancelled";
  message = stateMessage;
  stateInt = 4;
  if (msg.sender != owner) throw;

  //OrderCancelled(uint _OrderCancelledState)

  return true;
  }
}