pragma solidity ^0.4.9;

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

pragma solidity ^0.4.9;

contract Invoice is PullPayment {

  event InvoicePaid(address _payeeAddress);


  address public payee;
  address public account;
  string public accountName;
  uint public invoiceAmount;
  string public description;
  uint public stateInt;
  bool public invoicePaid;

  function Invoice() {
    payee = msg.sender;

    stateMessage = "Created New Invoice";
    stateInt = 1;

    message = stateMessage;

  }

  function setInvoiceDetails(address _account, string _accountName, uint _invoiceAmount,  string _description) {
  stateMessage = "Invoice details set";
  stateInt = 2;
  accountName = _accountName;
  invoiceAmount = _invoiceAmount;
	description = _description;
	
  }


  function payInvoice(uint _payment, address _payeeAddress) external returns (bool success){
  stateMessage = "Invoice Paid";
  stateInt = 3;
  if (msg.sender != payee) throw;

  InvoicePaid(_payeeAddress);

  return true;
  }

}