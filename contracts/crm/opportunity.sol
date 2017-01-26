pragma solidity ^0.4.4;


import "../ownership/Ownable.sol";


contract Opportunity is Ownable {

  address owner;

  string public opportunityName;
  string public opportunityOwner;
  string public type;
  string public amount;
  string public industry;
  string public customerRating;
  string public description;
  string public closeDate;
  string public createdDate;
  uint public stateInt;

  function Opportunity() {
    owner = msg.sender;

    stateMessage = "Created New Opportunity";
    stateInt = 1;

    message = stateMessage;
    //eth = 1000000000000000000; // for some reason constructor isn't called
  }

  function setUpOpportunityDetails(uint price_, uint amount_,  string opportunityName_, string opportunityOwner_, string closeDate_, string blockStart_, string type_, string industry_, string description_) {
    stateMessage = "Opportunity details set";
    message = stateMessage;
    stateInt = 2;
    opportunityPrice = .03;
    opportunityName = opportunityName;
	  opportunityOwner = buyer;
	  createdDate = createdDate;
	  closeDate = closeDate;
	  description = description;
	
  }