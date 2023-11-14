// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma abicoder v2

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Clones} from "@openzeppelin/contracts/proxy/Clones.sol";
import {Nft721} from "./Nft721.sol";

contract NftFactory {
  uint256 public totalCollections;
  Nft721 private impl;
  mapping(address => address[]) public collections;

  event CollectionDeployed(address collection, address creator, string tokenURI);

  constructor(Nft721 _impl) {
    impl = _impl;
  }

  function newCollection(
    string memory _name,
    string memory _symbol,
    string memory _articleUri
  ) external returns (address) {
    address newCollection_ = Clones.clone(address(impl));
    address sender = msg.sender;

    Nft721(newCollection_).initialize(_name, _symbol, _articleUri);

    collections[sender].push(newCollection_);
    totalCollections += 1;

    emit CollectionDeployed(newCollection_, sender, _articleUri);

    return newCollection_;
  }
}
