pragma solidity ^0.4.4;

contract Assertive {
    function assert(bool assertion) internal {
        if (!assertion) throw;
    }
}