package org.bank.internal;

import org.junit.jupiter.api.Test;
import java.math.BigDecimal;
import static org.junit.jupiter.api.Assertions.*;

/*
 * AbstractMoneyAccount and AbstractCard superclasses are covered in CreditCardTest.
 */
class DebitCardTest {

    @Test
    void debitCardBalance() throws InvalidActionException {
        DebitCard card = new DebitCard("CardDebit", "RUB");
        assertEquals(BigDecimal.ZERO, card.balance);
    }

    @Test
    void debitCardForeignCurrency() throws InvalidActionException {
        DebitCard card = new DebitCard("CardDebit", "EUR");
        assertEquals(card.currency.getCurrencyCode(), "EUR");
    }

    @Test
    void debitCardInvalidCurrency() {
        Exception e = assertThrows(InvalidActionException.class,
                ()-> new DebitCard("Card1", "LOL"));

        assertEquals("The currency code is not a supported ISO 4217 code.", e.getMessage());
    }
}