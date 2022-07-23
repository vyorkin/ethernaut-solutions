// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import {Test} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";
import {Utils} from "./Utils.sol";

import {Ethernaut} from "../../game/Ethernaut.sol";
import {LevelFactory} from "../../game/LevelFactory.sol";

abstract contract LevelTest is Test {
    Utils internal utils;

    Ethernaut private ethernaut;
    LevelFactory internal levelFactory;
    address payable internal levelAddress;

    address payable[] internal users;
    address payable internal owner;
    address payable internal player;

    function setUp() public virtual {
        require(
            address(levelFactory) != address(0),
            "levelFactory is not initialized"
        );

        utils = new Utils();
        ethernaut = new Ethernaut();
        ethernaut.registerLevel(levelFactory);

        users = utils.createUsers(2);
        owner = users[0];
        player = users[1];

        vm.label(owner, "owner");
        vm.label(player, "player");
    }

    function create() external payable returns (address) {
        vm.prank(player);
        return ethernaut.createLevelInstance{value: msg.value}(levelFactory);
    }

    function run() public {
        init();
        exploit();
        check();
    }

    function init() internal virtual;

    function exploit() internal virtual;

    function check() internal {
        vm.startPrank(player);
        bool exploited = ethernaut.submitLevelInstance(levelAddress);
        assertTrue(exploited, "Not exploited");
        vm.stopPrank();
    }
}
