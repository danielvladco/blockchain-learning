// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract EncodingDecoding {
    function combineStrings() public pure returns (string memory) {
        return string(abi.encodePacked("Hello ", "World"));
    }

    // abi.encode is a low level function that can be used to encode anything to bytes
    function encodeNumber() public pure returns (bytes memory) {
        return abi.encode(1);
    }

    function encodeString() public pure returns (bytes memory) {
        return abi.encode("Hello");
    }
    // abi.encode is a low level function that can be used to encode anything to bytes but compressed
    function encodeStringPacked() public pure returns (bytes memory) {
        return abi.encodePacked("Hello");
    }

    // abi.decode is a way to decode a bytes array into a solidity type
    function decodeString() public pure returns (string memory) {
        return abi.decode(encodeString(), (string));
    }

    // can encode and decode multiple types at the same time
    function multiEncode() public pure returns (bytes memory) {
        return abi.encode("String1", "String2");
    }

    // returns two strings: "String1", "String2"
    function multiDecode() public pure returns (string memory, string memory) {
        (string memory str1, string memory str2) = abi.decode(multiEncode(), (string, string));
        return (str1, str2);
    }

    // can encode and decode multiple types at the same time
    function multiEncodePacked() public pure returns (bytes memory) {
        return abi.encodePacked("String1", "String2");
    }

    // Doesn't work, because the strings are packed!
    function multiDecodePacked() public pure returns (string memory, string memory) {
        (string memory str1, string memory str2) = abi.decode(multiEncodePacked(), (string, string));
        return (str1, str2);
    }

    // Packed encoding is similar to type casting; it will work and just cast the bytes to a string
    function multiStringCastPacked() public pure returns (string memory) {
        string memory str1 = string(multiEncodePacked());
        return str1;
    }
}