pragma solidity ^0.4.24;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract HealthcareWallet is Ownable {
    
    mapping(address => uint) public allowance;
    
    function addAllowance(address _who, uint _amount) public onlyOwner {
        allowance[_who] = _amount;
    }
    
    modifier ownerOrAllowed(uint _amount) {
        require(isOwner() || allowance[msg.sender] > _amount, "You are not allowed");
        _;
    }
    
    function withdrawMoney(address _to, uint _amount) public ownerOrAllowed(_amount) {
        _to.transfer(_amount);
    }
    
    function fallback () external payable {
        
    }
}