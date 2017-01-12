pragma solidity ^0.4.4;


import("./SafeMath.sol");
import("./net30.sol");
import("./Ownable.sol");

contract SimpleMSA {

    // This value is visible in etherscan.io explorer
    address public owner = 0x0;
    address public account = 0x0;
    address public primaryContact = 0x0;
    uint public contractValue;
    uint public startBlock;
    uint public endBlock;
    uint public payBlock;

    // Anyone can call this contract and override the value of the previous caller
    function simpleMSA(address accountInput, address contactInput, uint contractValue_, uint startBlockInput, uint endBlockInput, uint payBlockInput){
    	owner = msg.sender;
        account = accountInput;
        primaryContact = contactInput;
        contractValue = contractValue_;
        startBlock = startBlockInput;
        endBlock = endBlockInput;
        payBlock = payBlockInput;

    }

}