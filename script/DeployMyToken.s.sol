// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "../lib/forge-std/src/Script.sol";
import {MyTokenDeployer} from "../src/MyTokenDeployer.sol";

contract DeployMyToken is Script {
    function run() public {
        string memory rpc = vm.envString("SOCKET_RPC");
        vm.createSelectFork(rpc);

        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        MyTokenDeployer myTokenDeployer = MyTokenDeployer(vm.envAddress("COUNTER_DEPLOYER"));
        myTokenDeployer.deployContracts(421614);
        myTokenDeployer.deployContracts(84532);
        //myTokenDeployer.deployContracts();
    }
}