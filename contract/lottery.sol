// Raffle
//Enter thr lottery (paying some amount)
// pick a random winner (verifiably radom)
//winner to be selected every x minutes -> completely automated
//Chainlink Oracle -> Randomness Automated Execution (Chainlink keeper)

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

error Lottery__NotEnoughETHEntered();

contract Lottery is VRFConsumerBaseV2 {
    // State Variable
    uint256 private immutable i_entranceFee;
    address payable[] private s_players;

    //Events
    event LotteryEnter(address indexed player);

    constructor(address vrfCoordinateV2, uint256 entranceFee) VRFConsumerBaseV2(vrfCoordinateV2) {
         i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinatorV2);
        i_entranceFee = entranceFee;
    }

    function enterLottery() public payable {
        // required (msg.value > i_entranceFee, "Not Enough ETH")
        if (msg.value < i_entranceFee) {
            revert Lottery__NotEnoughETHEntered();
        }
        s_players.push(payable(msg.sender));
        // emit an event when we updatea dynamic array or mapping
        emit LotteryEnter(msg.sender);
    }

    function requestRandomWinner() external {
        //Request the random number
        // once we get it, do somthing with it
        // 2 transaction process
    }

    function fullfilRandomWords(
        uint256 requestId,
        uint256[] memory randomWords
    ) internal override {}

    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }

    function getPlayer(uint256 index) public view returns (address) {
        return s_players[index];
    }
}
