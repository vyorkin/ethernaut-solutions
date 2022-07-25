// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "../../game/LevelFactory.sol";
import "./Fallout.sol";

contract FalloutFactory is LevelFactory {
    function createInstance(address) public payable override returns (address) {
        Fallout instance = new Fallout();
        return address(instance);
    }

    function validateInstance(address payable _instance, address _player)
        public
        view
        override
        returns (bool)
    {
        Fallout instance = Fallout(_instance);
        return instance.owner() == _player;
    }
}
