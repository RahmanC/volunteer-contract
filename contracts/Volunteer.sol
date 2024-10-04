// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

interface IRewardToken {
    function reward(address _to, uint256 _amount) external;
}

contract VolunteerContract {
    address public owner;
    IRewardToken public rewardToken;
    uint256 public rewardRatePerHour; // tokens rewarded per hour of volunteer work

    struct Volunteer {
        uint256 totalHours;
        bool isRegistered;
    }

    mapping(address => Volunteer) public volunteers;

    event Registered(address volunteer);
    event HoursLogged(address volunteer, uint256 _hours);

    constructor(address _rewardToken, uint256 _rewardRatePerHour) {
        owner = msg.sender;
        rewardToken = IRewardToken(_rewardToken);
        rewardRatePerHour = _rewardRatePerHour;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function registerVolunteer() public {
        require(!volunteers[msg.sender].isRegistered, "Already registered");
        volunteers[msg.sender] = Volunteer(0, true);
        emit Registered(msg.sender);
    }

    function logHours(uint256 _hours) public {
        require(volunteers[msg.sender].isRegistered, "Not registered");
        volunteers[msg.sender].totalHours += _hours;
        uint256 rewardAmount = _hours * rewardRatePerHour;
        rewardToken.reward(msg.sender, rewardAmount);
        emit HoursLogged(msg.sender, _hours);
    }

    function updateRewardRate(uint256 _newRate) public onlyOwner {
        rewardRatePerHour = _newRate;
    }
}
