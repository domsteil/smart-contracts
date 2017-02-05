pragma solidity ^0.4.4;


import "../ownership/Ownable.sol";



contract Asset is Ownable {

  address public owner;
  uint public assetPrice;
  uint public guarantee;
  uint public eth = 1000000000000000000;
  string public products;
  string public stateMessage;
  string public message;
  string public activationDate;
  string public assetStatus
  uint public stateInt;

  function Asset() {
    owner = msg.sender;

    stateMessage = "Created New Asset";
    stateInt = 1;

    message = stateMessage;

  }


  function setUpAssetDetails(uint price, string products, address oracleAddress, string date, string status) {
    stateMessage = "Asset details set";
    message = stateMessage;
    oracle = oracleAddress;
    stateInt = 2;
    assetPrice = price;
    assetProducts = products;
	  activationDate = date;
	  assetStatus = status;
	
	
	
  }

}