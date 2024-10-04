// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RewardTokenContract is ERC20 {
    address public owner;

    constructor(uint256 initialSupply) ERC20("VolunteerToken", "VLT") {
        owner = msg.sender;
        _mint(msg.sender, initialSupply);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function reward(address _to, uint256 _amount) external onlyOwner {
        _transfer(owner, _to, _amount);
    }

    function mint(uint256 _amount) public onlyOwner {
        _mint(owner, _amount);
    }
}
