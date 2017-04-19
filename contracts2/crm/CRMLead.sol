pragma solidity ^0.4.6;

contract Lead {

event LeadConvertedToAccount(address _newAccountddress);
event LeadConvertedToContact(address _newLeadAddress);

string public firstName;
string public lastName;
string public title;
string public email;
string public phone;
string public stateMessage;
string public message; 
uint public stateInt;


function Lead(string firstName_, string lastName_, string email_, string phone_, string title_) {

stateMessage = "Created New Lead";
stateInt = 1;
firstName = firstName_;
lastName = lastName_;
title = title_;
phone = phone_;
email = email_;

message = stateMessage;

}

function updateContactDetails(string firstName_, string lastName_,string email_, string phone_, string title_) {

stateMessage = "Lead Details Updated";
stateInt = 2;
firstName = firstName_;
lastName = lastName_;
title = title_;
phone = phone_;
email = email_;

}
}