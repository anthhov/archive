package org.bank.internal;

public class SimpleDeposit extends AbstractDeposit {
    public SimpleDeposit(String name, String currencyName) throws InvalidActionException {
        super(name, currencyName);
    }
}
