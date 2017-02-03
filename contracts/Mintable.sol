pragma solidity ^0.4.0;

import {owned} from "example-package-owned/contracts/owned.sol";
import {StandardToken} from "example-package-standard-token/contracts/StandardToken.sol";

contract MintableToken is StandardToken(0), owned {
  function mint(address who, uint value) public onlyowner returns (bool) {
    balances[who] += value;
    totalSupply += value;
    Transfer(0x0, who, value);
    return true;
  }
}