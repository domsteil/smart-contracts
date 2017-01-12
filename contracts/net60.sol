pragma solidity ^0.4.4;


import './ERC20Basic.sol';
import './SafeMath.sol';
import './Ownable.sol';
import './Killable.sol';

contract net60 is Ownable, Killable {

  uint public startBlock; //contract start block (set in constructor)
  uint public endBlock; //contract end block (set in constructor)
  uint public payBlock = 6370284; // payment is due this many blocks after the startBlock (assuming 14 second blocks, this is two months )
  uint public paymentAmount;
  address public owner = 0x0; // Owner address for owner functions from ./Ownable.sol Owner is transferable.
  address public multisig = 0x0; 


  function net60(address multisigInput, uint startBlockInput, uint endBlockInput, uint payBlockInput, uint paymentAmountInput) {
        owner = msg.sender;
        multisig = multisigInput;
        startBlock = startBlockInput;
        endBlock = endBlockInput;
		    payBlock = payBlockInput;
        paymentAmount = paymentAmountInput;

  }

  function transfer(address _to, uint256 _value) returns (bool success) {
        if (block.number <= endBlock && block.number <= startBlock+payBlock) throw;
        return super.transfer(_to, _value);
    }

    /**
     * ERC 20 Standard Token interface transfer function
     *
     * Prevent transfers until token sale is over.
     */
    
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if (block.number <= endBlock && block.number <= startBlock+payBlock) throw;
        return super.transferFrom(_from, _to, _value);
    }

}