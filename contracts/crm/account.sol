pragma solidity ^0.4.4;


import "../ownership/Ownable.sol";


contract Account is Ownable {

  address public owner;
  address public account;
  string public accountName;
  string public parentAccount;
  string public phone;
  string public email;
  string public site;
  string public accountOwner;
  string public type;
  string public industry;
  string public customerRating;
  string public description;
  uint public stateInt;

  function Account() {
    owner = msg.sender;

    stateMessage = "Created New Account";
    stateInt = 1;

    message = stateMessage;

  }

  function setAccountDetails(bytes32 phone_, bytes32 accountName_, bytes32 accountOwner_, bytes32 type_, bytes32 industry_, bytes32 customerRating_, bytes32 description_) {
  stateMessage = "Account details set";
  accountName = accountName_;
  phone = phone_;
	accountOwner = accountOwner_;
	type = type_;
	industry = industry_;
	description = description_;
	customerRating = customerRating_;
	
  }