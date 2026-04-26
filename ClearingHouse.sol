// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./VirtualAMM.sol";

contract ClearingHouse {
    struct Position {
        uint256 size;
        uint256 margin;
        uint256 entryPrice;
        bool isLong;
    }

    IERC20 public collateralToken;
    mapping(address => Position) public positions;

    constructor(address _collateral) {
        collateralToken = IERC20(_collateral);
    }

    function openPosition(address vamm, bool isLong, uint256 margin, uint256 leverage) external {
        uint256 notional = margin * leverage;
        collateralToken.transferFrom(msg.sender, address(this), margin);
        
        uint256 size = VirtualAMM(vamm).getInputPrice(isLong, notional);
        
        positions[msg.sender] = Position({
            size: size,
            margin: margin,
            entryPrice: notional / size,
            isLong: isLong
        });
    }

    function getAccountValue(address user, address vamm) public view returns (int256) {
        Position memory pos = positions[user];
        if (pos.size == 0) return int256(pos.margin);
        
        // Mock PnL calculation
        return int256(pos.margin); 
    }
}
