// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "openzeppelin/access/Ownable.sol";

abstract contract LevelFactory is Ownable {
    function createInstance(address _player)
        public
        payable
        virtual
        returns (address);

    function validateInstance(address payable _instance, address _player)
        public
        virtual
        returns (bool);
}
