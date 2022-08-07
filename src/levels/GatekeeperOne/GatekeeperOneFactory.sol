// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {LevelFactory} from "../../game/LevelFactory.sol";
import {GatekeeperOne} from "./GatekeeperOne.sol";

contract GatekeeperOneFactory is LevelFactory {
    function createInstance(address) public payable override returns (address) {
        GatekeeperOne instance = new GatekeeperOne();
        return address(instance);
    }

    function validateInstance(address payable _instance, address _player)
        public
        view
        override
        returns (bool)
    {
        GatekeeperOne instance = GatekeeperOne(_instance);
        return instance.entrant() == _player;
    }
}
