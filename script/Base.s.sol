// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import {console2, Script} from "forge-std/Script.sol";
import {IScript} from ".//interfaces/IScript.sol";
import {ErrorHandler} from ".//libraries/ErrorHandler.sol";

abstract contract BaseScript is Script, IScript {
    using ErrorHandler for *;

    modifier broadcast() {
        vm.startBroadcast();
        _;
        vm.stopBroadcast();
    }

    function run(bytes calldata callData) external {
        (bool success, bytes memory returnOrRevertData) = address(this)
            .delegatecall(callData);
        success.handleRevert(returnOrRevertData);
    }
}
