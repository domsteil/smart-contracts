pragma solidity ^0.4.8;

import "./Assertive.sol";

/// @title Overflow aware uint math functions.
/// @author Melonport AG <team@melonport.com>
/// @notice Inspired by https://github.com/MakerDAO/maker-otc/blob/master/contracts/simple_market.sol
contract SafeMath is Assertive{

    function safeMul(uint a, uint b) internal returns (uint) {
        uint c = a * b;
        assert(a == 0 || c / a == b);
        return c;
    }

    function safeSub(uint a, uint b) internal returns (uint) {
        assert(b <= a);
        return a - b;
    }

    function safeAdd(uint a, uint b) internal returns (uint) {
        uint c = a + b;
        assert(c>=a && c>=b);
        return c;
    }

}