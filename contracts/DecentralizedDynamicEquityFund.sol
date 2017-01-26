pragma solidity ^0.4.8;

import("./SafeMath.sol");


contract DecentralizedDynamicEquityFund {

address public founder1 = 0x0; 
address public founder2 = 0x0;
uint public founder1GHRR = 150; // GHRR of 150$ per hour
uint public founder2GHRR = 50; // GHRR of 50$ per hour
uint public founder1hours = 0; // this will keep track of the hours founder 1 has logged
uint public founder2hours = 0; // this will keep track of the hours founder 2 has logged
uint public founder1Equity = 0; // this will keep track of the equity founder 1 has 
uint public founder2Equity = 0; // this will keep track of the equity founder 2 has 
uint public totalHours = 0; // this is the total hours that have logged by founder1Hours + founder2Hours
uint public totalEquity = 0; // this is the total equity that have logged by founder1Equity + founder2Equity
bool public fundActive = false;
uint public ownership = totalEquity / founder1Equity;

function DecentralizedDynamicEquityFund(address founder1Input, address founder2Input) {
founder1 = founder1Input;
founder2 = founder2Input;

}

function founder1log(address founder1){
	if (msg.sender != founder1) throw;
	uint hours = msg.hours;
	equity = safeMul(hours, founder1GHRR());
	founder1Hours = safeAdd(founder1hours, hours);
	founder1Equity = safeAdd(founder1Equity, equity);
	totalHours = safeAdd(founder1hours, founder2Hours);
	totalEquity = safeAdd(founder1Equity, founder2Equity);


}

function founder2log(address founder2){
	if (msg.sender != founder2) throw;
	uint hours = msg.hours;
	equity = safeMul(hours, founder2GHRR());
	founder2Hours = safeAdd(founder2hours, hours);
	founder2Equity = safeAdd(founder2Equity, equity);
	totalHours = safeAdd(founder1hours, founder2Hours);
	totalEquity = safeAdd(founder1Equity, founder2Equity);

}


function readEquity() constant returns(uint) {
		if (msg.sender != founder1 || msg.sender != founder2) throw;
        return totalEquity; // read only Total Equity
    }

function readHours() constant returns(uint) {
		if (msg.sender != founder1 || msg.sender != founder2) throw;
		return totalHours; // read only Total Hours
	}

function readfounder1Equity() constant returns(uint) {
		if (msg.sender != founder1 || msg.sender != founder2) throw;
        return founder1Equity; // read only Founder 1's Equity
    }

function readfounder2Equity() constant returns(uint) {
		if (msg.sender != founder1 || msg.sender != founder2) throw;
		return founder2Equity; // read only Founder 2's Equity
	}

function readfounder1Hours() constant returns(uint) {
		if (msg.sender != founder1 || msg.sender != founder2) throw;
		return founder1Hours; // read only Founder 1's Hours
	}

function readfounder2Hours() constant returns(uint) {
		if (msg.sender != founder1 || msg.sender != founder2) throw;
		return founder2Hours; // read only Founder 2's Hours
	}
function readownershipPercentage() constant returns(uint) {
		if (msg.sender != founder1 || msg.sender != founder2) throw;
		return ownership; // read only percent ownership
	} 
}