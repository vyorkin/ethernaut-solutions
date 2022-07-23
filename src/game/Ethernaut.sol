// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "./LevelFactory.sol";
import "openzeppelin/access/Ownable.sol";

contract Ethernaut is Ownable {
    // ----------------------------------
    // Owner interaction
    // ----------------------------------

    mapping(address => bool) registeredLevels;

    // Only registered levels will be allowed to
    // generate and validate level instances.
    function registerLevel(LevelFactory _level) public onlyOwner {
        registeredLevels[address(_level)] = true;
    }

    // ----------------------------------
    // Get/submit level instances
    // ----------------------------------

    struct EmittedInstanceData {
        address player;
        LevelFactory level;
        bool completed;
    }

    mapping(address => EmittedInstanceData) emittedInstances;

    event LevelInstanceCreatedLog(address indexed player, address instance);
    event LevelCompletedLog(address indexed player, LevelFactory level);

    function createLevelInstance(LevelFactory _level)
        public
        payable
        returns (address)
    {
        // Ensure level is registered.
        require(registeredLevels[address(_level)]);

        // Get level factory to create an instance.
        address instance = _level.createInstance{value: msg.value}(msg.sender);

        // Store emitted instance relationship with player and level.
        emittedInstances[instance] = EmittedInstanceData(
            msg.sender,
            _level,
            false
        );

        // Retrieve created instance via logs.
        emit LevelInstanceCreatedLog(msg.sender, instance);

        // Return data - not possible to read emitted events via solidity.
        return instance;
    }

    function submitLevelInstance(address payable _instance)
        public
        returns (bool)
    {
        // Get player and level.
        EmittedInstanceData storage data = emittedInstances[_instance];
        // Instance was emitted for this player.
        require(data.player == msg.sender);
        // Not already submitted.
        require(data.completed == false);

        // Have the level check the instance.
        if (data.level.validateInstance(_instance, msg.sender)) {
            // Register instance as completed.
            data.completed = true;

            // Notify success via logs.
            emit LevelCompletedLog(msg.sender, data.level);

            // Return data - not possible to read emitted events
            return true;
        }

        // Return data - not possible to read emitted events via solidity.
        return false;
    }
}
