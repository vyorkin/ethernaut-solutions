// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

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
