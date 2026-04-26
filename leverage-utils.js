/**
 * Utility to calculate maintenance margin and liquidation price
 */
function calculateLiquidationPrice(entryPrice, leverage, maintenanceMarginRatio = 0.05) {
    const margin = 1 / leverage;
    const distanceToLiquidation = margin - maintenanceMarginRatio;
    
    // For a Long position
    const liquidationPrice = entryPrice * (1 - distanceToLiquidation);
    
    return {
        entryPrice,
        liquidationPrice,
        isSafe: true
    };
}

module.exports = { calculateLiquidationPrice };
