/*
ARES Protocol

ARESRules - a BoardRoom rules contract implementing the ARES protocol.
*/

pragma solidity ^0.4.4;

import "Rules.sol";
import "Board.sol";
import "HoldingToken.sol";
import "SafeSend.sol";


contract ARESRules is Rules {
  modifier onlyboard() {
    if (msg.sender == address(board)) {
      _;
    } else {
      throw;
    }
  }

  modifier validBond(uint256 _nonce) {
    if (msg.value == minimumBondRequired
      && bonds[msg.sender][_nonce] == 0
      && board.nonces(msg.sender) == _nonce) {
      _;
    } else {
      throw;
    }
  }

  modifier saleEnded() {
    if (now > token.lastIssuance()) {
      _;
    } else {
      throw;
    }
  }

  function ARESRules(address _token, address _fund) public {
    token = HoldingToken(_token);
    board = Board(msg.sender);
    fund = _fund;
  }

  function changeVariables(
    uint256 _debatePeriod,
    uint256 _votingPeriod,
    uint256 _gracePeriod,
    uint256 _executionPeriod,
    uint256 _baseQuorum,
    uint256 _minimumBondRequired)
    public
    onlyboard {
    debatePeriod = _debatePeriod;
    votingPeriod = _votingPeriod;
    gracePeriod = _gracePeriod;
    executionPeriod = _executionPeriod;
    baseQuorum = _baseQuorum;
    minimumBondRequired = _minimumBondRequired;
    variableChangeVotingDate += variableChangePeriod;
  }

  function configureBoard(address _board) public onlyboard {
    if (!configured) {
      board = Board(_board);
    } else {
      throw;
    }
  }

  function postBond(uint256 _nonce) public payable saleEnded validBond(_nonce) {
    bonds[msg.sender][_nonce] += msg.value;
  }

  function sendFailedBond(uint256 _proposalID) public returns (uint256 bondPosted) {
    address from = board.createdBy(_proposalID);
    uint256 nonce = board.nonceOf(_proposalID);

    if (bonds[from][nonce] >= 0
      && now > (board.createdOn(_proposalID) + debatePeriod + votingPeriod + gracePeriod)
      && board.positionWeightOf(_proposalID, BOND_REFUND_VOTE) < baseQuorum
      && hasWon(from, _proposalID) == false) {
      bondPosted = bonds[from][nonce];
      bonds[from][nonce] = 0;

      if (!fund.send(bondPosted)) {
        throw;
      }
    } else { throw; }
  }

  function withdrawBond(uint256 _proposalID) public saleEnded {
    address from = board.createdBy(_proposalID);
    uint256 nonce = board.nonceOf(_proposalID);

    if (msg.sender == from
      && bonds[from][nonce] >= 0
      && (hasWon(_proposalID) || board.positionWeightOf(_proposalID, BOND_REFUND_VOTE) >= baseQuorum)) {
      uint256 bondPosted = bonds[from][nonce];
      bonds[from][nonce] = 0;
      address safeSend = address(new SafeSend(msg.sender));

      if(!safeSend.call.value(bondPosted)()) {
        throw;
      }
    } else { throw; }
  }

  function claimVariableChangeWinner(uint256 _proposalID) public saleEnded {
    if (isRulesChangeProposal(_proposalID)
      && board.positionWeightOf(_proposalID, YES_VOTE) > board.positionWeightOf(variableChangePID, YES_VOTE)) {
      variableChangePID = _proposalID;
    } else { throw; }
  }

  function isVariableChangeProposal(uint256 _proposalID) public constant returns (bool) {
    uint256 created = board.createdOn(_proposalID);

    if ((created >= variableChangeVotingDate && created < variableChangeVotingDate + 1 days)
      && board.proxyOf(_proposalID) == address(0)
      && board.destinationOf(_proposalID) == address(this)) {
      return true;
    }
  }

  function isRuleContractChangeProposal(uint256 _proposalID) public constant returns (bool) {
    address destination = board.destinationOf(_proposalID);

    if (board.proxyOf(_proposalID) == address(0)
      && (destination == address(board) || destination == address(fund))) {
      return true;
    }
  }

  function minimumQuorum(uint256 _value) public constant returns (uint256) {
    // minimum of 12% and maximum of 24%
    return token.totalSupply() / baseQuorum +
        (fund.balance * token.totalSupply() * baseQuorum) / _value;
  }

  function hasWon(uint256 _proposalID) public constant saleEnded returns (bool) {
    uint256 totalNoVotes = board.positionWeightOf(_proposalID, NO_VOTE);
    uint256 totalYesVotes = board.positionWeightOf(_proposalID, YES_VOTE);
    uint256 quorum = totalYesVotes;
    bool isVariableChanging = isVariableChangeProposal(_proposalID);
    bool isRuleContractChanging = isRuleContractChangeProposal(_proposalID);

    if(quorum > minimumQuorum(board.valueOf(_proposalID))
      && now > (board.createdOn(_proposalID) + debatePeriod + votingPeriod)
      && (!isVariableChanging || (_proposalID == variableChangePID && now > variableChangeVotingDate + 2 weeks))
      && (!isRuleContractChanging || (quorum > (token.totalSupply() / 51)))
      && totalYesVotes > totalNoVotes) {
      return true;
    }
  }

  function canExecute(address _sender, uint256 _proposalID) public constant saleEnded returns (bool) {
    if (hasWon(_proposalID)
      && (now < (board.createdOn(_proposalID) + debatePeriod + votingPeriod + gracePeriod + executionPeriod))
      && (now > (board.createdOn(_proposalID) + debatePeriod + votingPeriod + gracePeriod))) {
      return true;
    }
  }

  function canVote(address _sender, uint256 _proposalID, uint256 _position) public constant saleEnded returns (bool) {
    uint256 created = board.createdOn(_proposalID);

    if((_position == BOND_REFUND_VOTE
        && now > token.burnedAt(_sender)
        && now < token.burnedAt(_sender) + 1 days
        && token.burned(msg.sender) > 0)
      || ((_position == NO_VOTE || _position == YES_VOTE)
        && now > (created + debatePeriod)
        && now < (created + debatePeriod + votingPeriod)
        && (!isVariableChangeProposal(_proposalID) || (now < variableChangeVotingDate + 1 weeks))
        && token.holdUntil(_sender) > (created + debatePeriod + votingPeriod)
        && board.hasVoted(_proposalID, _sender) == false)) {
      return true;
    }
  }

  function canPropose(address _sender) public constant saleEnded returns (bool) {
    if(token.balanceOf(_sender) > 0
      && bonds[_sender][board.nonces(_sender)] == minimumBondRequired) {
      return true;
    }
  }

  function votingWeightOf(address _sender, uint256 _proposalID) public constant returns (uint256) {
    if (token.burnBalance(msg.sender) > 0) {
      return token.burnBalance(msg.sender);
    } else {
      return token.balanceOf(_sender);
    }
  }

  mapping(address => mapping(uint256 => uint256)) public bonds;
  uint256 public debatePeriod = 2 weeks;
  uint256 public votingPeriod = 1 weeks;
  uint256 public gracePeriod = 2 weeks;
  uint256 public executionPeriod = 1 weeks;
  uint256 public baseQuorum = 12;
  uint256 public minimumBondRequired = 1000 ether;

  uint256 public variableChangePeriod = (4 weeks) * 6;
  uint256 public variableChangeVotingDate = now + variableChangePeriod;
  uint256 public variableChangePID = 0;

  bool public configured;
  address public fund;
  Board public board;
  HoldingToken public token;

  uint256 public constant BOND_REFUND_VOTE = 2;
  uint256 public constant YES_VOTE = 1;
  uint256 public constant NO_VOTE = 0;
}