pragma solidity ^0.4.4;


import "../ownership/Ownable.sol";


contract Contact is Ownable {

  event ContactOwnerSwitched(address _newContactOwner);

  address owner;
  address contact;
  string public contactName;
  string public contactOwner;
  string public title;
  string public email;
  string public phone;
  uint stateInt;
  string public message;
  string public stateMessage;

  function Contact() {
    owner = msg.sender;

    stateMessage = "Created New Contact";
    stateInt = 1;

    message = stateMessage;

  }

  function setUpContactDetails(string _contactName, string _email, string _phone, string _title) {
    
    stateMessage = "Contact Details set";
    stateInt = 2;
    contactName = _contactName;
	  title = _title;
	  phone = _phone;
	  email = _email;
	
  }


        function switchContactOwnerAddress(address _newContactOwner) external returns (bool success){
        if (msg.sender != owner) throw;

        owner = _newContactOwner;
        ContactOwnerSwitched(_newContactOwner);

        return true;
    }

}

function deleteContact() onlyOwner {
    selfdestruct(owner);
  }
}