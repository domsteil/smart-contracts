pragma solidity ^0.4.4;

contract Active {

	bool internal isActive;

	modifier isUnActivated () {
		if (isActive) {

			throw;
		}
		isActive = true;
		_;
		isActive = false;
	}
}