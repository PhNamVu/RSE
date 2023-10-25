// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract MyNFT is ERC721Burnable, Ownable, Pausable {
    uint256 public constant maxSupply = 100;
    uint256 public totalSupply;
    uint256 private nextTokenId = 1; // The next available tokenId
    mapping(uint256 => string) private _tokenURIs;

    constructor() ERC721("MyNFT", "MNFT") {}

    // Mint function to create new tokens
    function mint(address to, string memory tokenURI) public onlyOwner {
        require(totalSupply + 1 <= maxSupply, "Max supply reached");
        uint256 tokenId = nextTokenId;
        nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        totalSupply = totalSupply + 1;
    }

    // Batch mint function to create multiple tokens at once
    function batchMint(
        address to,
        uint256 numTokens,
        string[] memory tokenURIs
    ) public onlyOwner {
        require(totalSupply + numTokens <= maxSupply, "Max supply reached");
        require(numTokens == tokenURIs.length, "Array lengths do not match");
        for (uint256 i = 0; i < numTokens; i++) {
            uint256 tokenId = nextTokenId;
            nextTokenId++;
            _safeMint(to, tokenId);
            _setTokenURI(tokenId, tokenURIs[i]);
        }
        totalSupply = totalSupply + numTokens;
    }

    // Batch transfer function to transfer multiple tokens at once
    function batchTransfer(
        address from,
        address to,
        uint256[] memory tokenIds
    ) public whenNotPaused {
        require(
            from == msg.sender || isApprovedForAll(from, msg.sender),
            "Not approved"
        );
        for (uint256 i = 0; i < tokenIds.length; i++) {
            safeTransferFrom(from, to, tokenIds[i]);
        }
    }

    // Function to set the token URI for a token
    function setTokenURI(
        uint256 tokenId,
        string memory tokenURI
    ) public onlyOwner {
        require(_exists(tokenId), "Token does not exist");
        _setTokenURI(tokenId, tokenURI);
    }

    // Function to get the token URI for a token
    function getTokenURI(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "Token does not exist");
        return _tokenURI(tokenId);
    }

    function _setTokenURI(uint256 tokenId, string memory tokenURI) internal {
        _tokenURIs[tokenId] = tokenURI;
    }

    function _tokenURI(uint256 tokenId) internal view returns (string memory) {
        return _tokenURIs[tokenId];
    }
}
