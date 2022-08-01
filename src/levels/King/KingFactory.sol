// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {LevelFactory} from "../../game/LevelFactory.sol";
import {King} from "./King.sol";

contract KingFactory is LevelFactory {
    function createInstance(address) public payable override returns (address) {
        King instance = new King();
        return address(instance);
    }

    function validateInstance(address payable _instance, address)
        public
        override
        returns (bool)
    {
        King instance = King(_instance);
        address(instance).call{value: 0}("");
        return instance._king() != address(this);
    }

    receive() external payable {}
}