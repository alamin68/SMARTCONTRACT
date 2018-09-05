/**********************************************************************
*These solidity codes have been obtained from Etherscan for extracting
*the smartcontract related info.
*The data will be used by MATRIX AI team as the reference basis for
*MATRIX model analysis,extraction of contract semantics,
*as well as AI based data analysis, etc.
**********************************************************************/
pragma solidity ^0.4.20;

interface token {
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
}

contract Sale {
    address private maintoken = 0x2054a15c6822a722378d13c4e4ea85365e46e50b;
    address private owner = msg.sender;
    uint256 private sendtoken;
    uint256 public cost1token = 0.0016 ether;
    token public tokenReward;
    
    function Sale() public {
        tokenReward = token(maintoken);
    }
    
    function() external payable {
        sendtoken = (msg.value)/cost1token;
        sendtoken = sendtoken*5/4;

        if (msg.value >= 45 ether) {
            sendtoken = (msg.value)/cost1token;
            sendtoken = sendtoken*2;
        }

        if (msg.value >= 100 ether) {
            sendtoken = (msg.value)/cost1token;
            sendtoken = sendtoken*3;
        }

        tokenReward.transferFrom(owner, msg.sender, sendtoken);
        owner.transfer(msg.value);
    }
}