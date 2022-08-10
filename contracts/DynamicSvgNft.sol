// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "base64-sol/base64.sol";
import "./PriceConverter.sol";

    error DynamicSvgNft_URIQueryForNonexistentToken();

contract DynamicSvgNft is ERC721 {
    uint s_tokenCounter = 0;
    string private i_lowSvg;
    string private i_highSvg;
    string private constant BASE64_URI_SVG_PREFIX = "data:image/svg+xml;base64,";
    string private constant BASE64_URI_JSON_PREFIX = "data:application/json;base64,";
    mapping(uint => uint) s_tokenIdToHighVal;

    event CreatedNFT(uint indexed tokenId, uint value);

    constructor(string memory lowSvg, string memory highSvg) ERC721("Dynamic SVC NFT", "DSN") {
        i_highSvg = svgToImageURI(highSvg);
        i_lowSvg = svgToImageURI(lowSvg);
    }
    function svgToImageURI(string memory svg) public pure returns (string memory) {
        string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(svg))));
        return string(abi.encodePacked(BASE64_URI_SVG_PREFIX, svgBase64Encoded));
    }

    function mintNft(uint value) public {
        s_tokenCounter++;
        s_tokenIdToHighVal[s_tokenCounter] = value;
        _safeMint(msg.sender, s_tokenCounter);
        emit CreatedNFT(s_tokenCounter, value);
    }

    function tokenURI(uint tokenId) public view override returns (string memory) {
        if (!_exists(tokenId)) {
            revert DynamicSvgNft_URIQueryForNonexistentToken();
        }
        string memory imageURI = i_lowSvg;
        if (PriceConverter.getPrice() >= s_tokenIdToHighVal[tokenId]) {
            imageURI = i_highSvg;
        }
        return string(abi.encodePacked(
                BASE64_URI_JSON_PREFIX,
                Base64.encode(abi.encodePacked(
                    '{"name":"', name(),
                    '", "description": "Nft that changes based on the Chainlink feed"}, "attributes": [{"trait_type":"coolness", "value": 100}], "image": "',
                    imageURI,
                    '"}'))));
    }
}