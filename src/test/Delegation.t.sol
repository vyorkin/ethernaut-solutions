// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {Ethernaut} from "../game/Ethernaut.sol";
import {Delegate, Delegation} from "../levels/Delegation/Delegation.sol";
import {DelegationFactory} from "../levels/Delegation/DelegationFactory.sol";
import {LevelTest} from "./common/LevelTest.sol";

contract DelegationTest is LevelTest {
    Delegation private level;

    constructor() {
        levelFactory = new DelegationFactory();
    }

    function testDelegation() public {
        run();
    }

    function init() internal override {
        levelAddress = payable(this.create());
        level = Delegation(levelAddress);

        assertEq(level.owner(), address(levelFactory));
    }

    function exploit() internal override {
        vm.startPrank(player);

        vm.stopPrank();
    }
}
