pragma solidity ^0.4.8;

contract Flipper {

	enum GameState {noWager, wagerMade, wagerAccepted}
	enum InvoiceState { notSubmitted, intitiated, paid, notPaid}
	GameState public currentState;


function Flipper() {
	currentState = GameState.noWager;
}

function transitionInvoiceState(bytes32 targetState) returns (bool) {
	if(targetState == "noWager") {
		currentState = GameState.noWager;
		return true;
		}
		else if (targetState == "wagerMade") {
			currentState = GameState.wagerMade;
			return true;
		}
		else if (targetState == "wagerAccepted") {
			currentState = GameState.wagerAccepted;
			return true;
		}

		return false;

	}

}


pragma solidity ^0.4.4;


/*
 * PullPayment
 * Base contract supporting async send for pull payments.
 * Inherit from this contract and use asyncSend instead of send.
 */
contract PullPayment {
  mapping(address => uint) public payments;

  // store sent amount as credit to be pulled, called by payer
  function asyncSend(address dest, uint amount) internal {
    payments[dest] += amount;
  }

  // withdraw accumulated balance, called by payee
  function withdrawPayments() {
    address payee = msg.sender;
    uint payment = payments[payee];
    
    if (payment == 0) throw;
    if (this.balance < payment) throw;

    payments[payee] = 0;
    if (!payee.send(payment)) {
      throw;
    }
  }
}


contract Escrow {
	
	address public buyer;
	address public seller;
	address public arbiter;


	function Escrow(address _seller, address _arbiter) {
	  buyer = msg.sender;
	  seller = _seller;
	  arbiter = _arbiter;

	}

	function payoutToSeller() {
		if(msg.sender == buyer || msg.sender = arbiter) {
		  seller.send(this.balance);
	}
}

	function refundToBuyer() {
		if(msg.sender == seller || msg.sender == arbiter) {
		  buyer.send(this.balance);
	}
}

	function getBalance() constant returns (uint) {
		return this.balance:
	}
}