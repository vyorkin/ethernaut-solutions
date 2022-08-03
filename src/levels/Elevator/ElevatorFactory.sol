// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "../../game/LevelFactory.sol";
import "./Elevator.sol";

contract ElevatorFactory is LevelFactory {
    function createInstance(address) public payable override returns (address) {
        Elevator instance = new Elevator();
        return address(instance);
    }

    function validateInstance(address payable _instance, address)
        public
        view
        override
        returns (bool)
    {
        Elevator instance = Elevator(_instance);
        return instance.top();
    }
}
