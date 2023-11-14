// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma abicoder v2;

import {ERC721Upgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Nft721 is ERC721Upgradeable, OwnableUpgradeable {
  string private contractURI_;
  string private _extendedTokenURI;
  uint256 private _currentSupply;

  mapping(uint256 => string) private _eTokenURIs;

  function initialize(
    string memory _name,
    string memory _symbol,
    string memory _articleUri
  ) external initializer {
    __Ownable_init();
    __ERC721_init(_name, _symbol);
    transferOwnership(tx.origin);
    mint(tx.origin, _articleUri);
  }

  function mint(address to, string memory _articleUri) public onlyOwner returns (uint256 tokenId) {
    tokenId = _currentSupply;

    _mint(to, tokenId);

    _eTokenURIs[tokenId] = _articleUri;

    _currentSupply += 1;
  }

  function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
    _requireMinted(tokenId);
    return _eTokenURIs[tokenId];
  }

  // function modifyExtendedURI(string memory extendedTokenURI_, uint256 tokenId) external onlyOwner {}
}
