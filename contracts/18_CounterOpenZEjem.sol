// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
import "./18_CounterOpenZ.sol";

contract CounterContract {
    event Log(string message);
    using Counters for Counters.Counter;
    Counters.Counter public counter;

    function increment() public returns (uint256) {
        counter.increment();
        return counter._value;
    }

    function decrement() public returns(uint256){
        counter.decrement();
        return counter._value;
    }



}
