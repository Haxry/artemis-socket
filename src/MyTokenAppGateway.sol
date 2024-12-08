// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "../lib/socket-protocol/contracts/base/AppGatewayBase.sol";
import "../lib/solady/src/auth/Ownable.sol";
import "./MyToken.sol";

contract MyTokenAppGateway is AppGatewayBase, Ownable {
    mapping(address => uint256) public airdropReceivers;

    constructor(
        address _addressResolver,
        address deployerContract_,
        FeesData memory feesData_
    ) AppGatewayBase(_addressResolver) Ownable() {
        addressResolver.setContractsToGateways(deployerContract_);
        _setFeesData(feesData_);
    }

    function addAirdropReceivers(
        address[] calldata receivers_,
        uint256[] calldata amounts_
    ) external onlyOwner {
        for (uint256 i = 0; i < receivers_.length; i++) {
            airdropReceivers[receivers_[i]] = amounts_[i];
        }
    }

    function claimAirdrop(address _instance) external async {
        uint256 amount = airdropReceivers[msg.sender];
        airdropReceivers[msg.sender] = 0;
        MyToken(_instance).mint(msg.sender, amount);
    }

    function transfer(
        uint256 amount,
        address srcForwarder,
        address dstForwarder
    ) external async {
       // address srcForwarder=0x86A8482B55D530091731b1b31c016eE809E0BbAA;
        //address destForwarder=0x1bCB643d2962F499e8a64a9F92FB232C401C6063;
        MyToken(srcForwarder).burn(amount);
        MyToken(dstForwarder).mint(msg.sender,amount);
    }
}