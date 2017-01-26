pragma solidity ^0.4.4;


import "../ownership/Ownable.sol";


contract Account is Ownable {

  address public owner;
  address public account;
  uint public annualRevenue;
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

  function setUpAccountDetails(uint phone_, uint annualRevenue,  string accountName_, string accountOwner_, string type_, string industry_, string customerRating_, string description_) {
  stateMessage = "Account details set";
  accountName = accountName_;
  phone = phone_;
	accountOwner = accountOwner_;
	type = type_;
	industry = industry_;
	description = description_;
	customerRating = customerRating_;
	
  }