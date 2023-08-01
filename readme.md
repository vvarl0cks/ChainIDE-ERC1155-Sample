# ERC-1155 Smart Contract Deployment Tutorial

## Introduction

[ChainIDE](https://chainide.com/) is a chain-agnostic, 
cloud-based IDE for creating decentralized applications to deploy on different blockchains such as Ethereum, BNB Chain, 
Polygon, Conflux, Nervos, Dfinity, Flow, Chain33, FISCO BCOS, etc. It enhances the development cycle through pre-configured plugins that save users time and effort. 
If you have any questions, feel free to ask us in the [ChainIDE Discord](https://discord.gg/QpGq4hjWrh).

## Pre-requisites

1.  ChainIDE 

2.  MetaMask

3.  Solidity

4.  IPFS

## What You'll Do

Following are the general steps to deploy an ERC-1155 smart contract:

1.  Install Metamask 
2.  Write an ERC-1155 smart contract
3.  Compile an ERC-1155 smart contract
4.  Deploy an ERC-1155 smart contract
5.  Create a flattened contract using the flattener library for verification
6.  Verify the deployed smart contract on EtherScan
7.  ERC-1155 interaction/minting

### 1. Install Metamask

When we deploy a smart contract to a blockchain or interact with the deployed smart contract, we need to pay the gas fee, and for that, we need to have a Web3 wallet, MetaMask.
So, let's install the MetaMask wallet.
Please click [here](https://metamask.io/) to install the MetaMask wallet; meanwhile, we need to switch the network to Goerli and get test tokens on Goerli.
Click on the MetaMask wallet plugin, log in to the MetaMask wallet, open the testnet in the settings, and switch to Goerli.

![change to goerli](https://3869740696-files.gitbook.io/~/files/v0/b/gitbook-x-prod.appspot.com/o/spaces%2F-MZ6_j0WUFnBhwIdP3LR%2Fuploads%2F7r8aUlo6Ipety4BPEpyS%2Fimage.png?alt=media&token=6b6a1674-06c3-4309-8e93-3fe453b24e9a)

Please use any of the below-mentioned Goerli faucets to receive tokens for Goeri test network. 

1. [Goerli faucet by alchemy](https://goerlifaucet.com/?utm_source=buildspace.so&utm_medium=buildspace_project)
2. [Goerli faucet by ChainLink](https://faucets.chain.link/goerli?utm_source=buildspace.so&utm_medium=buildspace_project) 

Amount limt: 0.1 ETH / 24 Hours

Finally, make sure your network is switched to goerli and has at least 0.1 GoerliETH.

![](https://d3gvnlbntpm4ho.cloudfront.net/ERC-721+deployment+on+Goerli/1.png)

### 2. Write an ERC-1155 smart contract

You need to write down all the necessary functions implemented in the ERC-1155 smart contract. 
A general [ERC-1155](https://eips.ethereum.org/EIPS/eip-1155) smart contract fhave the following functions:

-   _safeTransferFrom(): Transfer "values" amount of "ids" from "from" address to specified "to" address (safe call)_
    
-   _safeBatchTransferFrom(): Transfer "values" of "ids" from the "from" address to the specified "to" address in batches (safe call)_
    
-   _balanceOf(): Returns the number of NFTs owned by a user_
    
-   _balanceOfBatch(): Returns the corresponding number of NFTs owned by multiple users_
    
-   _setApprovalForAll(): Grant the address _operator to have control of all NFTs, and trigger the ApprovalForAll event after success. _
    
-   _isApprovedForAll(): Check if an address is authorized to another address_
    

The ChainIDE team has prepared a full ERC-1155 contract including all required functions,
you can use this built-in template and add/remove some functions according to your requirements.

Once you open the "EXPLORER" panel, you can see a smart contract ArtCollectible.sol.
Don't rush to compile it; we have some other things to do first.

![image-20221107110835327](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221107110835327.png)

After you finish writing your smart contract, click the "Connect Wallet" button in the upper right corner, select the "Injected Web3 Provider" 
button, then select on MetaMask, and connect to the MetaMask wallet (Ethereum Mainnet is the main network, 
Goerli Test Network is the test network - we connect to the GoerliTest Network).

![image-20221101164650695](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101164650695.png)

### 3. Upload Metadata

First, prepare the pictures to be uploaded. Take a rock, scissors, and cloth as examples.
The corresponding IDs are 1, 2, and 3, and they are placed in the same folder.

![image-20220701170302373](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Rinkeby+Etherum/image-20220701170302373.png)

Then enter [Pinata](https://www.pinata.cloud/), a webpage dedicated to uploading files to IPFS
(Other IPFS upload sites are also available, such as [NFT.Storage](https://nft.storage/)).

Click "Upload" - "Folder" - select the folder where the rock-paper-scissors pictures are stored and upload them to IPFS.

![image-20220701172546437](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Rinkeby+Etherum/image-20220701172546437.png)

![image-20220701172620417](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Rinkeby+Etherum/image-20220701172620417.png)


After the upload is successful, enter the folder, click the name of the image, and you can see the image stored on IPFS.

![image-20220701175341505](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Rinkeby+Etherum/image-20220701175341505.png)

The information behind ipfs/ in the address bar will be used later, so pay attention to it.

![image-20220701175913228](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Rinkeby+Etherum/image-20220701175913228.png)
Next, we need to create a corresponding number of json files and upload them to IPFS (here 3)

In order to meet the URI rules of ERC1155

-   json filenames must be hexadecimal lowercase alphanumerics without the 0x prefix.
    
-   Must be zero-padded to 64 hex characters long    

Metadata Template：

```json
{  
 "title": "Token Metadata",  
 "type": "object",  
 "properties": {  
 "name": {  
 "type": "string",  
 "description": "Identifies the asset to which this token represents"  
 },  
 "decimals": {  
 "type": "integer",  
 "description": "The number of decimal places that the token amount should display - e.g. 18, means to divide the token amount by 1000000000000000000 to get its user representation."  
 },  
 "description": {  
 "type": "string",  
 "description": "Describes the asset to which this token represents"  
 },  
 "image": {  
 "type": "string",  
 "description": "A URI pointing to a resource with mime type image/* representing the asset to which this token represents. Consider making any images at a width between 320 and 1080 pixels and aspect ratio between 1.91:1 and 4:5 inclusive."  
 },  
 "properties": {  
 "type": "object",  
 "description": "Arbitrary properties. Values may be strings, numbers, object or arrays."  
 }  
 }  
}
```

So, create a new folder locally, and create 3 json files, the folder name and content are as follows,
**And replace the link after image with ipfs:// plus the IPFS image suffix above**:

0000000000000000000000000000000000000000000000000000000000000001.json

```json
{  
 "name": "Rock",  
 "description": "Rock Paper Scissors",  
 "image": "ipfs://QmTj1D7wFN9wjW7toQhaKmkRpq6W4L3V5Q1VE274bLETn8/1.jpg",  
 "properties": {  
 "like": "scissors",  
 "hate": "papper",  
 "rarity": "common"  
 }  
}
```

![image-20220701180402498](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Rinkeby+Etherum/image-20220701180402498.png)

0000000000000000000000000000000000000000000000000000000000000002.json

```json
{  
 "name": "Paper",  
 "description": "Rock Paper Scissors",  
 "image": "ipfs://QmTj1D7wFN9wjW7toQhaKmkRpq6W4L3V5Q1VE274bLETn8/2.jpg",  
 "properties": {  
 "like": "Rock",  
 "hate": "Scissors",  
 "rarity": "common"  
 }  
}
```

![image-20220701180558765](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Rinkeby+Etherum/image-20220701180558765.png)

0000000000000000000000000000000000000000000000000000000000000003.json

```json
{  
 "name": "Scissors",  
 "description": "Rock Paper Scissors",  
 "image": "ipfs://QmTj1D7wFN9wjW7toQhaKmkRpq6W4L3V5Q1VE274bLETn8/3.jpg",  
 "properties": {  
 "like": "Paper",  
 "hate": "Rock",  
 "rarity": "common"  
 }  
}
```
![image-20220701180626097](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Rinkeby+Etherum/image-20220701180626097.png)

![image-20220701180840933](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Rinkeby+Etherum/image-20220701180840933.png)


Upload this folder containing 3 JSON files to IPFS via Pinata.

![image-20220701180940682](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Rinkeby+Etherum/image-20220701180940682.png)

Copy the CID of the JSON folder, which we will use when writing the contract (e.g., QmY4qTkh8jWL6zmGnDrNGZVWTTmiHhJaw3CnheJrJNKWcU)

![image-20220701181117511](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Rinkeby+Etherum/image-20220701181117511.png)

### 4. Compile an ERC-1155 smart contract

Before compiling, you need to replace "QmY4qTkh8jWL6zmGnDrNGZVWTTmiHhJaw3CnheJrJNKWcU"
on line 14 with the CID of your generated JSON folder, and replace Rock Paper Scissors on line 18 with the name of the collection you want to set.

![image-20220713112347261](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Rinkeby+Etherum/image-20220713112347261.png)


After completing your smart contract, it is time to compile the smart contract.
To compile your smart contact, visit the "Compile" module, select a suitable compiler according to your source code, and press the compile button; after the compilation is successful; the ABI and bytecode of the source code will be generated. If there are some errors in your source code,
they will be displayed under the console panel. You may need to read the error carefully, fix it accordingly and recompile it!

**Please note down the compiler version and license of your source code with optimizations enabled** as it will be required when you verify your smart contract on EtherScan.

![image-20221101165057305](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101165057305.png)

### 5. Deploy an ERC-1155 smart contract

After the compilation is successful, it is time to deploy your compiled ERC-1155 smart contract to the Goerli test network. To do this, you need to install a MetaMask, join the Goerli test network in your MetaMask, and claim some test coins to pay for gas. Then enter the "Depoly & Interaction" module, select the contract you want to deploy in the compiled smart contract and deploy it.

In this tutorial, we will use the ArtCollectible smart contract for deployment.

![image-20221101165231647](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101165231647.png)

After the successful deployment, you can see a message in the console section indicating that your smart contract has been successfully deployed.

### 6. Create a flattened contract for verification

In order to verify a smart contract that imports other smart contracts, we need to create a flat file.
A flat file puts all the source codes of the imported contract in one file.
To create a flat file, you need first to add a "flattener" plugin.

![image-20221101165407763](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101165407763.png)

Once the Flatterner plugin is activated, you can click to access it on the right side of the screen, as shown in the image below.
Select the compiled file and click the Flatten button to create a flattened file once the flattened file is created.
It will be automatically copied to the clipboard. You can paste it into a file and save it for later use.

![image-20221101165944621](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101165944621.png)

If you want to save the flattened file, click the save button and a flattened contract will be saved in the current repository.

![image-20221101170029110](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101170029110.png)

Saved flattened contracts can be accessed under the resource manager module.

![image-20221101170145190](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101170145190.png)


### 7. Verify the deployed contract on EtherScan

#### 7.1. Verify a smart contract through the EtherScan web page.

To verify a previously deployed smart contract, click here.

![image-20221101170728667](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101170728667.png)

Click "Contract" - "Verify and Publish" below.

![image-20221101170805394](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101170805394.png)

一 Once you click "Verify your contract", you will be asked to provide the following.

-   Contract Address: The address of the deployed smart contract you want to verify
    
-   Compiler Type: Choose whether you want to verify a single file or multiple files
    
-   Compiler Version: The compiler version you used to compile the contract
    
-   License: The type of open-source license your source code uses

![image-20221101172537847](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101172537847.png)


After that, you need to paste the flat file you created in step 5 and delete the content of the Constructor Arguments (because we didn't pass in the parameters in the constructor).
Click Verify and Publish, and your smart contract will be verified.

![image-20221101172630049](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101172630049.png)

Your smart contract has been verified; congratulations!

![image-20221101172713511](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101172713511.png)

#### 7.2. Verify a contract via EtherScan API 
If you don't want to use the above method, you can also use the API method to verify the contract.
Activate the etherscan-verifier plugin in the plugin bar

![image-20221101173431299](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101173431299.png)

Click the etherscan-verify plugin in the right column, and click the jump icon to go to the etherscan official website.

![image-20221101173510042](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101173510042.png)

Select Login or Register on the login page

![image-20221027111355382](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221027111355382.png)

Select API Keys

![image-20221027111522996](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221027111522996.png)

Click Add

![image-20221027111608852](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221027111608852.png)

Enter a name for your new API key, and click the "Create New API Key" button.

![image-20221027111744468](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221027111744468.png)

In this way, your API Key Token will be generated (be careful not to show it to others, only for your own use), click the icon to copy

![image-20221027111938619](https://d3gvnlbntpm4ho.cloudfront.net/ERC721+deployment+on+Goerli+Etherum/goerli721.assets/image-20221027111938619.png)

and paste into ChainIDE

![image-20221101173637210](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101173637210.png)

Copy the contract address you want to verify

![image-20221101173653085](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101173653085.png)

After pasting, click Verify

![image-20221101173720038](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101173720038.png)

Verification succeeded!

![image-20221101173736110](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101173736110.png)



### 8. ERC-1155 Mint

To mint ERC-1155, you need to use the **mint function** and use the wallet address of the person you want to airdrop ERC1155,
and enter the corresponding metadata id (e.g., 1 for rock, 2 for scissors, 3 for paper) and If you want the number of airdrops, click Submit after confirming that it is correct.

![image-20221101173928463](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221101173928463.png)

After successful minting, you can view your NFT on OpenSea NFT Market or Rarible.
Visit [OpenSea Testnet](https://testnets.opensea.io/) or [Rarible Testnet](https://testnet.rarible.com/),
connect your MetaMask wallet, and make sure the selected network is Goerli, you You can see NFTs that have been successfully minted in the market.

![image-20221102103034464](https://d3gvnlbntpm4ho.cloudfront.net/ERC1155+deployment+on+Goerli+Etherum/1155_goerli.assets/image-20221102103034464.png)


Congratulations, you issued your ERC-1155 on Goerli! That's all for this tutorial.

