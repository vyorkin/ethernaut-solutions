// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {LevelFactory} from "../../game/LevelFactory.sol";
import {Reentrance} from "./Reentrance.sol";

contract ReentranceFactory is LevelFactory {
    function createInstance(address) public payable override returns (address) {
        Reentrance instance = new Reentrance();

        // We can send some initial ETH to it, since
        // the Reentrance contract has the receive function

        address addr = address(instance);
        (bool result, ) = addr.call{value: 0.0001 ether}("");
        require(result, "failed to send ether");

        return addr;
    }

    function validateInstance(address payable _instance, address)
        public
        view
        override
        returns (bool)
    {
        Reentrance instance = Reentrance(_instance);
        return address(instance).balance == 0;
    }

    receive() external payable {}
}