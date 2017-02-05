pragma solidity ^0.4.4;

contract Renewed{

	bool internal isRenewed;

	modifier isNotRenewed () {
		if (isRenewed) {

			throw;
		}
		isRenewed = true;
		_;
		isRenewed = false;
	}
}