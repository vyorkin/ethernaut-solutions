// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {LevelFactory} from "../../game/LevelFactory.sol";
import {Telephone} from "./Telephone.sol";

contract TelephoneFactory is LevelFactory {
    function createInstance(address) public payable override returns (address) {
        Telephone instance = new Telephone();
        return address(instance);
    }

    function validateInstance(address payable _instance, address _player)
        public
        view
        override
        returns (bool)
    {
        Telephone instance = Telephone(_instance);
        return instance.owner() == _player;
    }
}
