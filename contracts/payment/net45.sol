pragma solidity ^0.4.4;


import './ERC20Basic.sol';
import './SafeMath.sol';
import './Ownable.sol';
import './Killable.sol';

contract net45 is Ownable, Killable {

  uint public startBlock; //contract start block (set in constructor)
  uint public endBlock; //contract end block (set in constructor)
  uint public payBlock = 3185142; // payment is due this many blocks after the startBlock (assuming 14 second blocks, this is one month )
  uint public paymentAmount;
  address public owner = 0x0; // Owner address for owner functions from ./Ownable.sol Owner is transferable.
  address public multisig = 0x0; 


  function net45(address multisigInput, uint startBlockInput, uint endBlockInput, uint payBlockInput, uint paymentAmountInput) {
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
        else {
        	selfdestruct(owner);
        }
    }

    /**
     * ERC 20 Standard Token interface transfer function
     *
     * Prevent contract payment after 30 days, if payment is sent; the contract will selfdestruct and the associated funds will be sent back to the owner of the contract. 
     */
    
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if (block.number <= endBlock && block.number <= startBlock+payBlock) throw;
        return super.transferFrom(_from, _to, _value);
        else {
        	selfdestruct(owner);
        }
    }

}