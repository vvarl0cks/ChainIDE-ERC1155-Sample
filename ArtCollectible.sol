// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ArtCollectible is Ownable, ERC1155 {
    // Base URI
    string private baseURI;
    string public name;

    constructor()
        ERC1155(
            'ipfs://QmY4qTkh8jWL6zmGnDrNGZVWTTmiHhJaw3CnheJrJNKWcU/{id}.json'
            //Replace QmY4qTkh8jWL6zmGnDrNGZVWTTmiHhJaw3CnheJrJNKWcU for your IPFS
        )
    {
        setName('Rock Paper Scissors');
    }

    function setURI(string memory _newuri) public onlyOwner {
        _setURI(_newuri);
    }

    function setName(string memory _name) public onlyOwner {
        name = _name;
    }

    function mintBatch(address _to, uint256[] memory ids, uint256[] memory amounts)
        public
        onlyOwner
    {
        _mintBatch(_to, ids, amounts, '');
    }

    function mint(address _to, uint256 id, uint256 amount) public onlyOwner {
        _mint(_to, id, amount, '');
    }
}