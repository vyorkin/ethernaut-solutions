// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {LevelFactory} from "../../game/LevelFactory.sol";
import {Force} from "./Force.sol";

contract ForceFactory is LevelFactory {
    function createInstance(address) public payable override returns (address) {
        return address(new Force());
    }

    function validateInstance(address payable _instance, address)
        public
        view
        override
        returns (bool)
    {
        Force instance = Force(_instance);
        return address(instance).balance > 0;
    }
}
