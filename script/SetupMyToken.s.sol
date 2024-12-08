// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "../lib/forge-std/src/Script.sol";
import {console} from "../lib/forge-std/src/console.sol";
import {MyTokenAppGateway} from "../src/MyTokenAppGateway.sol";
import {MyTokenDeployer} from "../src/MyTokenDeployer.sol";
import {FeesData} from "lib/socket-protocol/contracts/common/Structs.sol";
import {ETH_ADDRESS} from "lib/socket-protocol/contracts/common/Constants.sol";

contract SetupMyToken is Script {
    function run() public {
        address addressResolver = vm.envAddress("ADDRESS_RESOLVER");

        string memory rpc = vm.envString("SOCKET_RPC");
        vm.createSelectFork(rpc);

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Setting fee payment on Ethereum Sepolia
        FeesData memory feesData = FeesData({
            feePoolChain: 84532,
            feePoolToken: ETH_ADDRESS,
            maxFees: 1 ether
        });

        MyTokenDeployer myTokenDeployer = new MyTokenDeployer(
            addressResolver,
            feesData,
            "MyToken",
            "MTK",
            18
        );

        MyTokenAppGateway myTokenAppGateway = new MyTokenAppGateway(
            addressResolver,
            address(myTokenDeployer),
            feesData
        );

        console.log("MyTokenDeployer: ", address(myTokenDeployer));
        console.log("MyTokenAppGateway: ", address(myTokenAppGateway));
    }
}