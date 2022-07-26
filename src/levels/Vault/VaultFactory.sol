// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "../../game/LevelFactory.sol";
import "./Vault.sol";

contract VaultFactory is LevelFactory {
    function createInstance(address) public payable override returns (address) {
        bytes32 password = "A very strong secret password :)";
        Vault instance = new Vault(password);
        return address(instance);
    }

    function validateInstance(address payable _instance, address)
        public
        view
        override
        returns (bool)
    {
        Vault instance = Vault(_instance);
        return !instance.locked();
    }
}
