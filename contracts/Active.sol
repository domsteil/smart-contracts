pragma solidity ^0.4.4;

contract Active{
    function activate(bool activation) internal {
        if (!activation) throw;
    }
}