pragma solidity ^0.4.24;

contract NDA  {

  event NewNDACreated (address _newContractAddress);

  string public contractName;
  address public counterpartyName;
  string public startBlock;
  string public endBlock;
  string public status;
  string public contractType;
  string public contractHash;
  string public stateMessage;
  string public message;
  uint public stateInt;


  function NDA(string contractName_, address counterparty_, string startBlock_, string endBlock_, string status_, string contractType_, string contractHash_)  {

    stateMessage = "Created New NDA";
    stateInt = 1;
    contractName = contractName_;
    counterpartyName = counterparty_;
    startBlock = startBlock_;
    endBlock = endBlock_;
    status = status_;
    contractType = contractType_;
    contractHash = contractHash_;
    message = stateMessage;

  }

  function updateContractDetails(string contractName_, string startBlock_, string endBlock_, string status_, string contractType_, string contractHash_) {
    
    stateMessage = "NDA Details Updated";
    stateInt = 2;
    contractName = contractName_;
    startBlock = startBlock_;
    endBlock = endBlock_;
    status = status_;
    contractType = contractType_;
    contractHash = contractHash_;
    message = stateMessage;
	
  }

  function activateNDA() {
        
    stateMessage = "NDA is now In Effect";
    stateInt = 2;

    }



function terminateNDA() {
        
    stateMessage = "NDA is Terminated";
    stateInt = 3;

    }



function renewNDA() {
        
    stateMessage = "NDA is Renewed";
    stateInt = 4;

    }



function expiredNDA() {
        
    stateMessage = "NDA is Expired";
    stateInt = 5;
    
    }

}