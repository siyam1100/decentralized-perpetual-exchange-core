// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

contract VirtualAMM is Ownable {
    uint256 public quoteAssetReserve;
    uint256 public baseAssetReserve;
    
    event ReservesSynced(uint256 quoteReserve, uint256 baseReserve);

    constructor(uint256 _quoteReserve, uint256 _baseReserve) Ownable(msg.sender) {
        quoteAssetReserve = _quoteReserve;
        baseAssetReserve = _baseReserve;
    }

    /**
     * @dev Calculates the output amount based on x * y = k
     */
    function getInputPrice(bool isLong, uint256 amount) external view returns (uint256) {
        uint256 k = quoteAssetReserve * baseAssetReserve;
        if (isLong) {
            uint256 newQuoteReserve = quoteAssetReserve + amount;
            uint256 newBaseReserve = k / newQuoteReserve;
            return baseAssetReserve - newBaseReserve;
        } else {
            uint256 newBaseReserve = baseAssetReserve + amount;
            uint256 newQuoteReserve = k / newBaseReserve;
            return quoteAssetReserve - newQuoteReserve;
        }
    }

    function updateReserves(uint256 _quote, uint256 _base) external onlyOwner {
        quoteAssetReserve = _quote;
        baseAssetReserve = _base;
        emit ReservesSynced(_quote, _base);
    }
}
