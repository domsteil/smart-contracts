pragma solidity ^0.4.4;


import './ERC20Basic.sol';
import './SafeMath.sol';
import './Ownable.sol';
import './Killable.sol';

contract Warranties is Ownable {

  uint public startBlock; //contract start block (set in constructor)
  uint public endBlock; //contract end block (set in constructor)
  uint public payBlock = 3185142; // payment is due this many blocks after the startBlock (assuming 14 second blocks, this is one month )
  uint public warrantyBlock = 3185142 * 2;


  address public owner = 0x0; // Owner address for owner functions from ./Ownable.sol Owner is transferable.
  address public multisig = 0x0; 


}