// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "forge-std/src/Test.sol";

abstract contract Helper is Test {
    address payable dev;
    address payable[] users;

    enum Forks {
        MAINNET,
        OPTIMISM,
        ARBITRUM,
        POLYGON,
        BASE
    }

    mapping (Forks forkedChain => uint256 forkId) forkIds;

    constructor() {
        Users helper = new Users();
        users = helper.create(20);
        dev = users[0];
    }

    function advanceBlocks(uint256 delta) internal returns (uint256 blockNumber) {
        blockNumber = block.number + delta;
        vm.roll(blockNumber);
    }

    function advanceTime(uint256 delta) internal returns (uint256 timestamp) {
        timestamp = block.timestamp + delta;
        vm.warp(timestamp);
    }

    // ======= CREATE FORKS ======= 
    function forkMainnet() internal {
        uint256 _forkId = vm.createFork(vm.envString("MAINNET_RPC_URL"));
        forkIds[Forks.MAINNET] = _forkId;
    }

    function forkMainnet(uint256 blockNumber) internal {
        uint256 _forkId = vm.createFork(vm.envString("MAINNET_RPC_URL"), blockNumber);
        forkIds[Forks.MAINNET] = _forkId;
    }

    function forkOptimism(uint256 blockNumber) internal {
        uint256 _forkId = vm.createFork(vm.envString("OPTIMISM_RPC_URL"), blockNumber);
        forkIds[Forks.OPTIMISM] = _forkId;
    }

    function forkArbitrum() internal {
        uint256 _forkId = vm.createFork(vm.envString("ARBITRUM_RPC_URL"));
        forkIds[Forks.ARBITRUM] = _forkId;
    }

    function forkArbitrum(uint256 blockNumber) internal {
        uint256 _forkId = vm.createFork(vm.envString("ARBITRUM_RPC_URL"), blockNumber);
        forkIds[Forks.ARBITRUM] = _forkId;
    }

    function forkPolygon() internal {
        uint256 _forkId = vm.createFork(vm.envString("POLYGON_RPC_URL"));
        forkIds[Forks.POLYGON] = _forkId;
    }

    function forkPolygon(uint256 blockNumber) internal {
        uint256 _forkId = vm.createFork(vm.envString("POLYGON_RPC_URL"), blockNumber);
        forkIds[Forks.POLYGON] = _forkId;
    }

    function forkBase() internal {
        uint256 _forkId = vm.createFork(vm.envString("BASE_RPC_URL"));
        forkIds[Forks.BASE] = _forkId;
    }

    function forkBase(uint256 blockNumber) internal {
        uint256 _forkId = vm.createFork(vm.envString("BASE_RPC_URL"), blockNumber);
        forkIds[Forks.BASE] = _forkId;
    }

    // ======= SELECT FORKS =======
    function selectMainnet() internal {
        uint256 forkId = forkIds[Forks.MAINNET];
        vm.selectFork(forkId);
    }

    function selectOptimism() internal {
        uint256 forkId = forkIds[Forks.OPTIMISM];
        if (forkId == 0) {
            revert("Create a fork first");
        }
        vm.selectFork(forkId);
    }

    function selectArbitrum() internal {
        uint256 forkId = forkIds[Forks.ARBITRUM];
        vm.selectFork(forkId);
    }

    function selectPolygon() internal {
        uint256 forkId = forkIds[Forks.POLYGON];
        vm.selectFork(forkId);
    }

    function selectBase() internal {
        uint256 forkId = forkIds[Forks.BASE];
        vm.selectFork(forkId);
    }

    // ======= CREATE AND SELECT FORKS =======
    function forkSelectMainnet() internal {
        uint256 _forkId = vm.createSelectFork(vm.envString("MAINNET_RPC_URL"));
        forkIds[Forks.MAINNET] = _forkId;
    }

    function forkSelectMainnet(uint256 blockNumber) internal {
        uint256 _forkId = vm.createSelectFork(vm.envString("MAINNET_RPC_URL"), blockNumber);
        forkIds[Forks.MAINNET] = _forkId;
    }

    function forkSelectOptimism(uint256 blockNumber) internal {
        uint256 _forkId = vm.createSelectFork(vm.envString("OPTIMISM_RPC_URL"), blockNumber);
        forkIds[Forks.OPTIMISM] = _forkId;
    }

    function forkSelectArbitrum(uint256 blockNumber) internal {
        uint256 _forkId = vm.createSelectFork(vm.envString("ARBITRUM_RPC_URL"), blockNumber);
        forkIds[Forks.ARBITRUM] = _forkId;
    }

    function forkSelectPolygon(uint256 blockNumber) internal {
        uint256 _forkId = vm.createSelectFork(vm.envString("POLYGON_RPC_URL"), blockNumber);
        forkIds[Forks.POLYGON] = _forkId;
    }

    function forkSelectBase(uint256 blockNumber) internal {
        uint256 _forkId = vm.createSelectFork(vm.envString("BASE_RPC_URL"), blockNumber);
        forkIds[Forks.BASE] = _forkId;
    }

    function makePersistent(address contractAddress) internal {
        vm.makePersistent(contractAddress);
    }
}

contract Users is Test {
    bytes32 internal nextUser = keccak256(abi.encodePacked("user address"));

    function next() internal returns (address payable) {
        address payable user = payable(address(uint160(uint256(nextUser))));
        nextUser = keccak256(abi.encodePacked(nextUser));
        return user;
    }

    function create(uint256 num) external returns (address payable[] memory) {
        address payable[] memory users = new address payable[](num);
        for (uint256 i = 0; i < num; i++) {
            address payable user = next();
            vm.deal(user, 100 ether);
            users[i] = user;
        }
        return users;
    }
}