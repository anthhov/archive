package org.bank.internal;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Currency;

public abstract class AbstractMoneyAccount {
    protected final String name;
    protected final Currency currency;
    protected BigDecimal balance;

    public void addMoney(String amount) throws InvalidActionException {
            BigDecimal addedAmount = new BigDecimal(amount);
            if (addedAmount.compareTo(BigDecimal.ZERO) > 0) {
                balance = balance.add(addedAmount);
            } else {
                throw new InvalidActionException("The amount added to the balance should be greater than 0.");
            }
    }

    public String getBalance() throws InvalidActionException {
            return balance.setScale(2, RoundingMode.HALF_UP).toString();
    }

    public AbstractMoneyAccount(String name, String currencyName) throws InvalidActionException {
        if (name != null && !name.isEmpty()) {
            this.name = name;
        } else {
            throw new InvalidActionException("The name must be non-empty string.");
        }

        if (currencyName != null && !currencyName.isEmpty()) {
            try {
                this.currency = Currency.getInstance(currencyName);
            } catch (IllegalArgumentException e) {
                throw new InvalidActionException("The currency code is not a supported ISO 4217 code.");
            }
        } else {
            throw new InvalidActionException("The currency code name must be non-empty string.");
        }

        this.balance = BigDecimal.ZERO;
    }
}
