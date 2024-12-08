// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MyTokenAppGateway} from "../src/MyTokenAppGateway.sol";

contract AddReceivers is Script {
    address[] receivers = [
        0x372610Bdcfa0531B40C8b27bb22A4e198eF04604
    ];
    uint256[] amounts = [
        5
    ];

    function run() public {
        string memory rpc = vm.envString("SOCKET_RPC");
        vm.createSelectFork(rpc);

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        MyTokenAppGateway myTokenAppGateway = MyTokenAppGateway(vm.envAddress("COUNTER_APP_GATEWAY"));
        //myTokenAppGateway.addAirdropReceivers(receivers, amounts);
        address srcForwarder=0xc026fD8628b998578F28a93424da64fe1cbfFd5D;
        address dstForwarder=0x3C7090297B42104F285D083B8DbeF7e85EC84F77;
        myTokenAppGateway.transfer(1000, srcForwarder, dstForwarder);
    }
}