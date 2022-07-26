// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "../../game/LevelFactory.sol";
import "./CoinFlip.sol";

contract CoinFlipFactory is LevelFactory {
    function createInstance(address) public payable override returns (address) {
        return address(new CoinFlip());
    }

    function validateInstance(address payable _instance, address)
        public
        view
        override
        returns (bool)
    {
        CoinFlip instance = CoinFlip(_instance);
        return instance.consecutiveWins() >= 10;
    }
}
