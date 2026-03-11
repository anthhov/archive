package org.bank.internal;

import java.math.BigDecimal;

public abstract class AbstractCard extends AbstractMoneyAccount {
    public AbstractCard(String name, String currencyName) throws InvalidActionException {
        super(name, currencyName);
    }

    public void chargeMoney(String amount) throws InvalidActionException {
        BigDecimal addedAmount = new BigDecimal(amount);
        if (addedAmount.compareTo(BigDecimal.ZERO) > 0) {
            if (balance.subtract(addedAmount).compareTo(BigDecimal.ZERO) < 0)
                throw new InvalidActionException("The amount subtracted should be less than the balance.");
            this.balance = balance.subtract(addedAmount);
        } else {
            throw new InvalidActionException("The amount subtracted from the balance should be greater than 0.");
        }
    }
}
