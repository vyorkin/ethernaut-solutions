// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {Ethernaut} from "../game/Ethernaut.sol";
import {Fallout} from "../levels/Fallout/Fallout.sol";
import {FalloutFactory} from "../levels/Fallout/FalloutFactory.sol";
import {LevelTest} from "./common/LevelTest.sol";

contract FalloutTest is LevelTest {
    Fallout private level;

    constructor() {
        levelFactory = new FalloutFactory();
    }

    function testFallout() public {
        run();
    }

    function init() internal override {
        levelAddress = payable(this.create());
        level = Fallout(levelAddress);
    }

    function exploit() internal override {
        vm.startPrank(player);
        level.Fal1out();
        vm.stopPrank();
    }
}
