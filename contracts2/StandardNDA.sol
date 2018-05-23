pragma solidity ^0.4.16;

/**
* @title Ownable
* @dev The Ownable contract has an owner address, and provides basic authorization control
* functions, this simplifies the implementation of "user permissions".
*/
contract Ownable {
  address public owner;


  /**
   * @dev The Ownable constructor sets the original `owner` of the contract to the sender
   * account.
   */
  function Ownable() {
    owner = msg.sender;
  }


  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }


  /**
   * @dev Allows the current owner to transfer control of the contract to a newOwner.
   * @param newOwner The address to transfer ownership to.
   */
  function transferOwnership(address newOwner) onlyOwner {
    if (newOwner != address(0)) {
      owner = newOwner;
    }
  }

}

contract StandardNDA {

    enum ContractStatus {created, inEffect}
    ContractStatus public currentStatus;


    address public owner = 0x0;
    address public account = 0x0;
    address public account2 = 0x0;
    string public disclosureType;
    uint public startBlock;
    uint public stateInt;
    string public stateMessage;
    string public message;
    string public status;

    
    function standardNDA(address accountInput, address account2Input, string typeInput, uint startBlockInput, string statusInput){
        owner = msg.sender;
        stateMessage = "NDA Created";
        stateInt = 1;
        message = stateMessage;
        currentStatus = ContractStatus.created;
        account = accountInput;
        account2 = account2Input;
        disclosureType = typeInput;
        status = statusInput;
        startBlock = startBlockInput;

    }
    
    function activateNDA() {
        
    stateMessage = "NDA InEffect";
    stateInt = 2;
    }

}


function terminateNDA() {
        
    stateMessage = "NDA Terminated";
    stateInt = 3;

    }

}


function renewNDA() {
        
    stateMessage = "NDA Renewed";
    stateInt = 4;

    }

}



function expiredNDA() {
        
    stateMessage = "NDA Expired";
    stateInt = 5;
    
    }

}


