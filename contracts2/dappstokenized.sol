pragma solidity ^0.4.4;

import "./StandardToken.sol";
import "./Ownable.sol";
import "./Stoppable.sol";




contract DappsToken is StandardToken, Ownable {

  string public name = "dapps token";
  string public symbol = "DAPT";
  uint public decimals = 18;
  
  uint public startBlock; //crowdsale start block (set in constructor)
  uint public endBlock; //crowdsale end block (set in constructor)
  
  address public founder = 0x0; // Initial founder address (set in constructor). All deposited ETH will be instantly forwarded to this multisig wallet.
  address public owner = 0x0; // Owner address for owner functions from ./Ownable.sol Owner is transferable.
  address public multisig = 0x0;
  address public developer = 0x0;
  address public rewards = 0x0;
  address public ecosystem = 0x0;
  address public charity = 0x0; 
  
  bool public rewardAddressesSet = false;
  uint public etherCap = 15000000 * 10**18; //max amount raised during crowdsale (150M USD worth of ether will be measured with a moving average market price at beginning of the crowdsale)
  uint public transferLockup = 3185142; //transfers are locked for this many blocks after endBlock (assuming 14 second blocks, this is 2 months)
  uint public founderLockup = 1126285; //founder allocation cannot be created until this many blocks after endBlock (assuming 14 second blocks, this is 6 months)

  uint public rewardsAllocation = 2; //2% tokens allocated post-crowdsale for swarm rewards
  uint public developerAllocation = 5; //5% of token supply allocated post-crowdsale for the developer fund
  uint public founderAllocation = 8; //8% of token supply allocated post-crowdsale for the founder allocation
  uint public bountyAllocation = 2500000 * 10**18; //2.5M tokens allocated post-crowdsale for the bounty fund
  uint public ecosystemAllocation = 5; //5% of token supply allocated post-crowdsale for the ecosystem fund
  uint public charityAllocation = 5; //5% of token supply allocated post-crowdsale for the charity fund

  bool public allocated = false; //this will change to true when the rewards are allocated
  bool public bountyAllocated = false; //this will change to true when the bounty fund is allocated
  bool public rewardsAllocated = false; // this will change to true when the reward fund is allocated
  bool public developerAllocated = false; //this will change to true when the developer fund is allocated
  bool public ecosystemAllocated = false; //this will change to true when the ecosystem fund is allocated
  bool public founderAllocated = false; //this will change to true when the founder fund is allocated
  bool public charityAllocated = false; //this will change to true when the charity fund is allocated

  uint public presaleTokenSupply = 0; //this will keep track of the token supply created during the crowdsale
  uint public presaleEtherRaised = 0; //this will keep track of the Ether raised during the crowdsale 
  bool public halted = false; //the founder address can set this to true to halt the crowdsale due to emergency
  bool public marketactive = false; //the market is not active

  event Buy(address indexed sender, uint eth, uint fbt);
  event Withdraw(address indexed sender, address to, uint eth);
  
    function DappsToken(address multisigInput, uint startBlockInput, uint endBlockInput) {
        owner = msg.sender;
        multisig = multisigInput;

        startBlock = startBlockInput;
        endBlock = endBlockInput;
    }
  
    function setRewardAddresses(address founderInput, address developerInput, address rewardsInput, address ecosystemInput, address charityInput){
        if (msg.sender != owner) throw;
        if (rewardAddressesSet) throw;
        founder = founderInput;
        developer = developerInput;
        rewards = rewardsInput;
        ecosystem = ecosystemInput;
        charity = charityInput;

        rewardAddressesSet = true;
    }
    
    function price() constant returns(uint) {
        if (block.number>=startBlock && block.number<startBlock+250) return 125; //power hour
        if (block.number<startBlock || block.number>endBlock) return 75; //default price
        return 75 + 4*(endBlock - block.number)/(endBlock - startBlock + 1)*34/4; //crowdsale price
    }

    // price() exposed for unit tests
    function testPrice(uint blockNumber) constant returns(uint) {
        if (blockNumber>=startBlock && blockNumber<startBlock+250) return 125; //power hour
        if (blockNumber<startBlock || blockNumber>endBlock) return 75; //default price
        return 75 + 4*(endBlock - blockNumber)/(endBlock - startBlock + 1)*34/4; //crowdsale price
    }
    
     function buy() {
        buyRecipient(msg.sender);
    }
    
    function buyRecipient(address recipient) {
        if (block.number<startBlock || block.number>endBlock || safeAdd(presaleEtherRaised,msg.value)>etherCap || halted) throw;
        uint tokens = safeMul(msg.value, price());
        balances[recipient] = safeAdd(balances[recipient], tokens);
        totalSupply = safeAdd(totalSupply, tokens);
        presaleEtherRaised = safeAdd(presaleEtherRaised, msg.value);

        if (!multisig.call.value(msg.value)()) throw; //immediately send Ether to multisig address

        // if etherCap is reached - activate the market
        if (presaleEtherRaised == etherCap && !marketactive){
            marketactive = true;
        }

        Buy(recipient, msg.value, tokens);

    }
    
    function allocateTokens() {
        
        // make sure founder/developer/rewards/ecosystem/charity addresses are configured

        if(founder == 0x0 || developer == 0x0 || rewards == 0x0 || ecosystem == 0x0 || charity == 0x0 ) throw;

        if (msg.sender != owner && msg.sender != founder && msg.sender != developer && msg.sender != rewards && msg.sender != ecosystem && msg.sender != charity ) throw;
        
        // it should only continue if endBlock has passed OR presaleEtherRaised has not reached the cap yet
        if (block.number <= endBlock && presaleEtherRaised < etherCap) throw;
        if (allocated) throw;
        presaleTokenSupply = totalSupply;


        // total token allocations add up to 25% of total coins, so formula is reward=allocation_in_percent/75 .
        balances[founder] = safeAdd(balances[founder], presaleTokenSupply * founderAllocation / 75 );
        totalSupply = safeAdd(totalSupply, presaleTokenSupply * founderAllocation / 75);
        
        balances[developer] = safeAdd(balances[developer], presaleTokenSupply * developerAllocation / 80);
        totalSupply = safeAdd(totalSupply, presaleTokenSupply * developerAllocation / 75);
        
        balances[rewards] = safeAdd(balances[rewards], presaleTokenSupply * rewardsAllocation / 75);
        totalSupply = safeAdd(totalSupply, presaleTokenSupply * rewardsAllocation / 75);

        balances[ecosystem] = safeAdd(balances[ecosystem], presaleTokenSupply * ecosystemAllocation / 75);
        totalSupply = safeAdd(totalSupply, presaleTokenSupply * ecosystemAllocation / 75);

        balances[charity] = safeAdd(balances[charity], presaleTokenSupply * charityAllocation / 75);
        totalSupply = safeAdd(totalSupply, presaleTokenSupply * charityAllocation / 75);


        allocated = true;

    }
    
    //*** Emergency stop of the ICO - Applicable tests:  Test unhalting, buying, and succeeding
    

    function halt() {
        if (msg.sender!=founder && msg.sender != developer && msg.sender != ecosystem && msg.sender != charity) throw;
        halted = true;
    }

    function unhalt() {
        if (msg.sender!=founder && msg.sender != developer && msg.sender != ecosystem && msg.sender != charity) throw;
        halted = false;
    }

     
    
    function changeMultisig(address newMultisig) {
        if (msg.sender!=owner) throw;
        multisig = newMultisig;
    }



    function transfer(address _to, uint256 _value) returns (bool success) {
        if (block.number <= endBlock && marketactive == false) throw;
        return super.transfer(_to, _value);
    }

    
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if (block.number <= endBlock && marketactive == false) throw;
        return super.transferFrom(_from, _to, _value);
    }


    function() {
        buyRecipient(msg.sender);
    }

}