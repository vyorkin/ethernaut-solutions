// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {LevelFactory} from "../../game/LevelFactory.sol";
import {Delegate, Delegation} from "./Delegation.sol";

contract DelegationFactory is LevelFactory {
    Delegate private delegate;

    constructor() {
        address owner = address(0);
        delegate = new Delegate(owner);
    }

    function createInstance(address) public payable override returns (address) {
        return address(new Delegation(address(delegate)));
    }

    function validateInstance(address payable _instance, address _player)
        public
        view
        override
        returns (bool)
    {
        Delegation delegation = Delegation(_instance);
        return delegation.owner() == _player;
    }
}
