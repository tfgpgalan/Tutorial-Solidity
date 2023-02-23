// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

library CounterLib {
    struct Counter { uint256 i; }

    function incremented(Counter storage self) internal returns (uint256) {
        return ++self.i;
    }
}

contract CounterContract {
    using CounterLib for CounterLib.Counter;
    CounterLib.Counter public counter;
    constructor(){
        counter.i=10;
    }
    function increment() public returns (uint256) {
        return counter.incremented();
    }
}