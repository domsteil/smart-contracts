pragma solidity ^0.4.96


import "../ownership/Ownable.sol";


contract Account is Ownable {

  event AccountOwnerSwitched(address _newAccountOwner);


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

    stateMessage = "Account Created";
    stateInt = 1;

    message = stateMessage;

  }

  function setAccountDetails(string phone_, string accountName_, string type_, string industry_, string customerRating_, string description_) {
  stateMessage = "Account Details Updated";
  stateInt = 2;
  accountName = accountName_;
  phone = phone_;
	type = type_;
	industry = industry_;
	description = description_;
	customerRating = customerRating_;
	
  }


  function switchAccountOwnerAddress(address _newAccountOwner) external returns (bool success){
  stateMessage = "Account Owner Switched";
  if (msg.sender != owner) throw;

  owner = _newAccountOwner;
  AccountOwnerSwitched(_newAccountOwner);

  return true;
  }


function deleteAccount() onlyOwner {
    selfdestruct(owner);
  }
}