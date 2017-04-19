/*
ARES Protocol

Owned - a simple owned contract with some custom owner properties
*/

pragma solidity ^0.4.4;


/// @title A single owned campaign contract for instantiating ownership properties.
/// @author Nick Dodson <nick.dodson@consensys.net>
contract Owned {
  // only the owner can use this method
  modifier onlyowner() {
    if (msg.sender != owner) {
      throw;
    } else {
      _;
    }
  }

  // the owner property
  address public owner;
}