pragma solidity ^0.4.6;

contract MSA  {

  event NewMSACreated (address _newContractAddress);

  string public contractName;
  string public startBlock;
  string public endBlock;
  string public status;
  string public contractType;
  string public stateMessage;
  string public message;
  uint public stateInt;


  function MSA(string contractName_, string startBlock_, string endBlock_, string status_, string contractType_)  {

    stateMessage = "Created New MSA";
    stateInt = 1;
    contractName = contractName_;
    startBlock = startBlock_;
    endBlock = endBlock_;
    status = status_;
    contractType = contractType_;
    message = stateMessage;

  }

  function updateContractDetails(string contractName_, string startBlock_, string endBlock_, string status_, string contractType_) {
    
    stateMessage = "MSA Details Updated";
    stateInt = 2;
    contractName = contractName_;
    startBlock = startBlock_;
    endBlock = endBlock_;
    status = status_;
    contractType = contractType_;
    message = stateMessage;
	
  }

}