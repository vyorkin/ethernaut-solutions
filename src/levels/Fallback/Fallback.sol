// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "openzeppelin/utils/math/SafeMath.sol";

contract Fallback {
    using SafeMath for uint256;
    mapping(address => uint256) public contributions;
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
        contributions[msg.sender] = 1000 * (1 ether);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }

    function contribute() public payable {
        require(msg.value < 0.001 ether, "msg.value must be < 0.001");
        contributions[msg.sender] += msg.value;
        if (contributions[msg.sender] > contributions[owner]) {
            owner = payable(msg.sender);
        }
    }

    function getContribution() public view returns (uint256) {
        return contributions[msg.sender];
    }

    function withdraw() public onlyOwner {
        owner.transfer(address(this).balance);
    }

    receive() external payable {
        require(msg.value > 0 && contributions[msg.sender] > 0);
        owner = payable(msg.sender);
    }
}
