pragma solidity ^0.4.4;


import "../ownership/Ownable.sol";



contract Lead is Ownable {

  address owner;
  address lead;
  uint eth = 1000000000000000000;

  string public contactName;
  string public contactOwner;
  string public title;
  string public email;
  string public phone;
  uint public stateInt;

  function Lead() {
    owner = msg.sender;

    stateMessage = "Created New Lead";
    stateInt = 1;

    message = stateMessage;

  }

  function setUpContactDetails(uint price, uint amount,  string contactName, string email, string phone, string contactOwner, string title, address oracleAddress) {
    
    stateMessage = "Contact Lead set";
    stateInt = 2;
    contactPrice = .02;
    contactName = contactName;
	  contactOwner = buyer;
	  title = title;
	  phone = phone;
	  email = email;
	
  }