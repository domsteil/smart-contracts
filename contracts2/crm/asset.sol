pragma solidity ^0.4.4;


import "../ownership/Ownable.sol";



contract Asset is Ownable {

  event AssetIsActivated(uint _ActivatedState);
  event AssetIsCancelled(uint _CancelledState);
  event AssetIsRenewed(uint _RenewedState);
  event AssetIsTerminated(uint _TerminatedState);


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

  function Order() {
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

      function activateAsset(uint _ActivatedState) external returns (bool success){
        if (msg.sender != owner) throw;

        stateMessage = "Asset Activated";
        state = _ActivatedState;
        stateInt = 3;
        AssetIsActivated(_ActivatedState);

        return true;
    }


        function cancelAsset(uint _CancelledState) external returns (bool success){
        if (msg.sender != owner) throw;

        stateMessage = "Asset Cancelled";
        state = __CancelledState;
        stateInt = 4;
        AssetIsCancelled(_CancelledState);

        return true;
    }


        function renewAsset(address _RenewedState) external returns (bool success){
        if (msg.sender != owner) throw;

        stateMessage = "Asset Renewed";
        state = _RenewedState;  
        stateInt = 5;
        AssetIsRenewed(_RenewedState);

        return true;
    }


        function termianteAsset(address _TerminatedState) external returns (bool success){
        if (msg.sender != owner) throw;


        stateMessage = "Asset Terminated";
        state = _TerminatedState;
        stateInt = 6;
        AssetIsTerminated(_TerminatedState);

        return true;
    }

}