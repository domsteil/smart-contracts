pragma solidity ^0.4.8;




contract TimeKeeper {

address public sender;
uint public startBlock;
uint public endBlock;


function timeKeeper () {
	public sender = msg.sender;


}

function log(uint st_, uint bt_) {
	st_ = startBlock;
	bt_ = endBlock;

}

}

