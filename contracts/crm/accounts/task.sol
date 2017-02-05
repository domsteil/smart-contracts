pragma solidity ^0.4.4;


import "../ownership/Ownable.sol";


contract Task is Ownable {

  address public owner;
  address public account;
  bytes32 public accountName;
  bytes32 public phone;
  bytes32 public email;
  bytes32 public accounttype;
  bytes32 public industry;
  bytes32 public customerRating;
  bytes32 public description;

  function Task (bytes32 phone_, bytes32 email_, bytes32 accountName_, bytes32 accountType_, bytes32 industry_, bytes32 customerRating_, bytes32 description_) {
    owner = msg.sender;
    accountName = accountName_;
    phone = phone_;
    email = email_;
    accountType = accountType_;
    industry = industry_;
    description = description_;
    customerRating = customerRating_;

  }

}