package org.bank.internal;

import java.math.BigDecimal;

abstract class AbstractDeposit extends AbstractMoneyAccount {
    protected boolean isOpen;

    public void close() throws InvalidActionException {
        if (!this.isOpen)
            throw new InvalidActionException("The account is already closed.");
        if (this.balance.compareTo(BigDecimal.ZERO) != 0)
            throw new InvalidActionException("The balance is not 0.");

        this.isOpen = false;
    }

    @Override
    public void addMoney(String amount) throws InvalidActionException {
        if (this.isOpen) {
            BigDecimal addedAmount = new BigDecimal(amount);
            if (addedAmount.compareTo(BigDecimal.ZERO) > 0) {
                balance = balance.add(addedAmount);
            } else {
                throw new InvalidActionException("The amount added to the balance should be greater than 0.");
            }
        } else {
            throw new InvalidActionException("The account is closed.");
        }
    }

    @Override
    public String getBalance() throws InvalidActionException {
        if (this.isOpen) {
            return balance.toString();
        } else {
            throw new InvalidActionException("The account is closed.");
        }
    }

    public AbstractDeposit(String name, String currencyName) throws InvalidActionException {
        super(name, currencyName);
        this.isOpen = true;
    }
}
