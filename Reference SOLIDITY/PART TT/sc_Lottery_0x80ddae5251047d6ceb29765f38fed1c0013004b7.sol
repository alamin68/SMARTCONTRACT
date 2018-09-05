/**********************************************************************
*These solidity codes have been obtained from Etherscan for extracting
*the smartcontract related info.
*The data will be used by MATRIX AI team as the reference basis for
*MATRIX model analysis,extraction of contract semantics,
*as well as AI based data analysis, etc.
**********************************************************************/
contract Lottery {
    event GetBet(uint betAmount, uint blockNumber, bool won); 

    struct Bet {
        uint betAmount;
        uint blockNumber;
        bool won;
    }

    address private organizer;
    Bet[] private bets;

    // Create a new lottery with numOfBets supported bets.
    function Lottery() {
        organizer = msg.sender;
    }
    
    // Fallback function returns ether
    function() {
        throw;
    }
    
    // Make a bet
    function makeBet() {
        // Won if block number is even
        // (note: this is a terrible source of randomness, please don't use this with real money)
        bool won = (block.number % 2) == 0; 
        
        // Record the bet with an event
        bets.push(Bet(msg.value, block.number, won));
        
        // Payout if the user won, otherwise take their money
        if(won) { 
            if(!msg.sender.send(msg.value)) {
                // Return ether to sender
                throw;
            } 
        }
    }
    
    // Get all bets that have been made
    function getBets() {
        if(msg.sender != organizer) { throw; }
        
        for (uint i = 0; i < bets.length; i++) {
            GetBet(bets[i].betAmount, bets[i].blockNumber, bets[i].won);
        }
    }
    
    // Suicide :(
    function destroy() {
        if(msg.sender != organizer) { throw; }
        
        suicide(organizer);
    }
}