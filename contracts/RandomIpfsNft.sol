// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

error RandomIpfsNft_RangeOutOfBounds();
error RandomIpfsNft_NeedMoreETHSent();
error RandomIpfsNft_TransferFailed();

contract RandomIpfsNft is VRFConsumerBaseV2, ERC721URIStorage, Ownable {
    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    uint64 private immutable i_subscriptionId;
    bytes32 private immutable i_gasLane;
    uint32 private immutable i_callbackGasLimit;
    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private constant NUM_WORDS = 1;
    mapping (uint => address) public s_requestIdToSender;
    uint public s_tokenCounter;
    uint constant MAX_CHANCE_VALUE = 100;
    string[3] private s_dogTokenUris;
    uint internal i_mintFee;
    enum Breed {
        BUG, SHIBA_INU, ST_BERNARD
    }
    event NftRequested(uint indexed requestId, address requester);
    event NftMinted(Breed dogBreed, address minter);

    constructor(
        address vrfCoordinatorV2,
        uint64 subscriptionId,
        bytes32 gasLane,
        uint32 callbackGasLimit,
        string[3] memory dogTokenUris,
        uint mintFee
) VRFConsumerBaseV2(vrfCoordinatorV2) ERC721("Random IPFS NFT", "RIN") {
        i_subscriptionId = subscriptionId;
        i_gasLane = gasLane;
        i_callbackGasLimit = callbackGasLimit;
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinatorV2);
        s_dogTokenUris = dogTokenUris;
        i_mintFee = mintFee;
    }
    function requestNft() public payable {
        if (msg.value < i_mintFee) {
            revert RandomIpfsNft_NeedMoreETHSent();
        }
        uint requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane,
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_WORDS);
        s_requestIdToSender[requestId] = msg.sender;
        emit NftRequested(requestId, msg.sender);
    }
    function fulfillRandomWords(uint requestId, uint[] memory randomWords) internal override {
        address dogOwner = s_requestIdToSender[requestId];
        uint newTokenId = s_tokenCounter;
        _safeMint(dogOwner, newTokenId);
        uint moddedRng = randomWords[0] % MAX_CHANCE_VALUE;
        Breed dogBreed = getBreedFromModdedRng(moddedRng);
        s_tokenCounter++;
        _safeMint(dogOwner, newTokenId);
        _setTokenURI(newTokenId, s_dogTokenUris[uint(dogBreed)]);
        emit NftMinted(dogBreed, dogOwner);
    }
    function withdraw() public onlyOwner {
        uint amount = address (this).balance;
        (bool success,) = payable(msg.sender).call{value: amount}("");
        if (!success) {
            revert RandomIpfsNft_TransferFailed();
        }
    }
    function getBreedFromModdedRng(uint moddedRng) public pure returns(Breed) {
        uint cumulativeSum = 0;
        uint[3] memory chanceArray = getChanceArray();
        for(uint i = 0; i < chanceArray.length; i++) {
            if (moddedRng >= cumulativeSum && moddedRng < cumulativeSum + chanceArray[i]) {
                return Breed(i);
            }
            cumulativeSum += chanceArray[i];
        }
        revert RandomIpfsNft_RangeOutOfBounds();
    }
    function getChanceArray() public pure returns (uint[3] memory) {
        return [10, 30, MAX_CHANCE_VALUE];
    }
    function getMintFee() public view returns(uint) {
        return i_mintFee;
    }
    function getDogTokenUris(uint index) public view returns(string memory) {
        return s_dogTokenUris[index];
    }
    function getTokenCounter() public view returns(uint) {
        return s_tokenCounter;
    }
}