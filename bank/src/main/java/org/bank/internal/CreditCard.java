package org.bank.internal;

import java.math.BigDecimal;

public class CreditCard extends AbstractCard {
    protected BigDecimal rate;
    protected BigDecimal initialBalance;
    public String getDebt() {
        return initialBalance.subtract(super.balance).toString();
    }

    public CreditCard(String name, String currencyName, String rate, String initialBalance) throws InvalidActionException {
        super(name, currencyName);

        if (!currencyName.equals("RUB"))
            throw new InvalidActionException("The only allowed currency for credit card is RUB.");

        BigDecimal balanceDecimal = new BigDecimal(initialBalance);

        if (balance.compareTo(BigDecimal.ZERO) <= 0) {
            super.balance = balanceDecimal;
            this.initialBalance = balance;
        } else {
            throw new InvalidActionException("The initial balance of the credit card should be greater than 0.");
        }

        BigDecimal rateDecimal = new BigDecimal(rate);
        if (rateDecimal.compareTo(BigDecimal.ZERO) < 0) {
            throw new InvalidActionException("The rate of the credit card should be greater than or equal to 0.");
        } else {
            this.rate = rateDecimal;
        }
    }
}
