package org.bank.internal;

public class DebitCard extends AbstractCard {
    DebitCard(String name, String currencyName) throws InvalidActionException {
        super(name, currencyName);
    }
}
