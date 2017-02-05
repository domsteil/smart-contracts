pragma solidity ^0.4.4;

contract Lead  {

  string public contactName;
  string public title;
  string public email;
  string public phone;
  string public stateMessage;
  uint public stateInt;


  function Lead() {

    stateMessage = "Created New Lead";
    stateInt = 1;

    message = stateMessage;

  }

  function setUpContactDetails(string contactName_, string email_, string phone_, string title_) {
    
    stateMessage = "Contact Lead Details Set";
    stateInt = 2;
    contactName = contactName_;
	  title = title_;
	  phone = phone_;
	  email = email_;
	
  }