/*
ARES Protocol

DAOFactory - allows the creation of an ARES Dao in a single transaction.
*/

pragma solidity ^0.4.4;

import "Rules.sol";
import "BoardRoom.sol";
import "HoldingToken.sol";
import "Fund.sol";
import "ARESRules.sol";


contract DAOFactory {
  function createDAO(uint256 _tokenCap,
    uint256 _tokenPrice,
    uint256 _lastIssuance,
    address _token,
    address _negationBoard,
    uint256 _negationProposalID,
    uint256 _negationPosition,
    address[] _whitelist,
    uint256 _baseQuorum,
    uint256 _debatePeriod,
    uint256 _votingPeriod,
    uint256 _gracePeriod,
    uint256 _executionPeriod,
    uint256 _minimumBondRequired)
    public
    returns (address rules, address board, address fund, address token) {
    fund = address(new Fund());
    token = address(new HoldingToken(_fund,
      _tokenCap,
      _tokenPrice,
      _lastIssuance,
      _token,
      _negationBoard,
      _negationProposalID,
      _negationPosition,
      _whitelist));
    rules = address(new ARESRules(token, fund));
    board = address(new BoardRoom(rules));
    Fund(fund).setToken(token);
    Fund(fund).transfer_ownership(board);
    if (_baseQuorum > 0) {
      rules = ARESRules(rules).changeVariables(
        _debatePeriod,
        _votingPeriod,
        _gracePeriod,
        _executionPeriod,
        _baseQuorum,
        _minimumBondRequired);
    }
    ARESRules(rules).configureBoard(board);

    isService[fund] = true;
    isService[token] = true;
    isService[board] = true;
    isService[rules] = true;
  }

  mapping(address => bool) public isService;
}