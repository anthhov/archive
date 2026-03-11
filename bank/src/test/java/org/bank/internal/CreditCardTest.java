package org.bank.internal;

import org.junit.jupiter.api.Test;
import java.math.BigDecimal;
import static org.junit.jupiter.api.Assertions.*;

/*
 * AbstractMoneyAccount and AbstractCard superclasses are covered here.
 */
class CreditCardTest {

    @Test
    void creditCardName() throws InvalidActionException {
        CreditCard card = new CreditCard("CreditCard#4", "RUB", "10.70", "50500.55");
        assertEquals("CreditCard#4", card.name);
    }

    @Test
    void creditCardCurrency() throws InvalidActionException {
        CreditCard card = new CreditCard("CreditCard#4", "RUB", "10.70", "50500.55");
        assertEquals("RUB", card.currency.getCurrencyCode());
    }

    @Test
    void creditCardBalance() throws InvalidActionException {
        CreditCard card = new CreditCard("CreditCard#4", "RUB", "10.70", "10100.79");
        assertEquals(BigDecimal.valueOf(10100.79), card.balance);
    }

    @Test
    void creditCardNullName() {
        Exception e = assertThrows(InvalidActionException.class,
                ()-> new CreditCard(null, "RUB", "30.00", "100000.23"));

        assertEquals("The name must be non-empty string.", e.getMessage());
    }

    @Test
    void creditCardEmptyName() {
        Exception e = assertThrows(InvalidActionException.class,
                ()-> new CreditCard("", "RUB", "2.56", "1.04"));

        assertEquals("The name must be non-empty string.", e.getMessage());
    }

    @Test
    void creditCardNullCurrency() {
        Exception e = assertThrows(InvalidActionException.class,
                ()-> new CreditCard("CreditCard 2", null, "30.00", "100000.00"));

        assertEquals("The currency code name must be non-empty string.", e.getMessage());
    }

    @Test
    void creditCardEmptyCurrency() {
        Exception e = assertThrows(InvalidActionException.class,
                ()-> new CreditCard("1", "", "2.56", "1.00"));

        assertEquals("The currency code name must be non-empty string.", e.getMessage());
    }

    @Test
    void creditCardInvalidCurrency() {
        Exception e = assertThrows(InvalidActionException.class,
                ()-> new CreditCard("Card1", "LOL", "2.56", "1.00"));

        assertEquals("The currency code is not a supported ISO 4217 code.", e.getMessage());
    }

    @Test
    void creditCardForeignCurrency() {
        Exception e = assertThrows(InvalidActionException.class,
                ()-> new CreditCard("Card1", "EUR", "2.56", "1.00"));

        assertEquals("The only allowed currency for credit card is RUB.", e.getMessage());
    }

    @Test
    void creditCardRate() throws InvalidActionException {
        CreditCard card = new CreditCard("CreditCard#4", "RUB", "18.56", "10100.79");
        assertEquals(BigDecimal.valueOf(18.56), card.rate);
    }

    @Test
    void creditCardNegativeRate() {
        Exception e = assertThrows(InvalidActionException.class,
                ()-> new CreditCard("CreditCard#4", "RUB", "-10.30", "10100.79"));
        assertEquals("The rate of the credit card should be greater than or equal to 0.", e.getMessage());
    }

    @Test
    void creditCardZeroRate() throws InvalidActionException {
        CreditCard card = new CreditCard("CreditCard#4", "RUB", "0", "10100.79");
        assertEquals(BigDecimal.valueOf(0), card.rate);
    }

    @Test
    void creditCardGetBalance() throws InvalidActionException {
        CreditCard card = new CreditCard("CreditCard", "RUB", "10.70", "90354.03");
        assertEquals("90354.03", card.getBalance());
    }

    @Test
    void creditCardAddMoney() throws InvalidActionException {
        CreditCard card = new CreditCard("CreditCard", "RUB", "10.70", "90354.00");
        card.addMoney("432450.58");
        card.addMoney("13.40");
        assertEquals("522817.98", card.getBalance());
    }

    @Test
    void creditCardAddMoneyZero() {
        Exception e = assertThrows(InvalidActionException.class,
                ()->{
                    CreditCard card = new CreditCard("CreditCard#4", "RUB", "10.30", "10100.79");
                    card.addMoney("0");
                });
        assertEquals("The amount added to the balance should be greater than 0.", e.getMessage());
    }

    @Test
    void creditCardAddMoneyNegative() {
        Exception e = assertThrows(InvalidActionException.class,
                ()->{
                    CreditCard card = new CreditCard("CreditCard#4", "RUB", "10.30", "10100.79");
                    card.addMoney("-47.30");
                });
        assertEquals("The amount added to the balance should be greater than 0.", e.getMessage());
    }

    @Test
    void creditCardChargeMoney() throws InvalidActionException {
        CreditCard card = new CreditCard("CreditCard", "RUB", "10.70", "90354.00");
        card.chargeMoney("2450.58");
        card.chargeMoney("1.00");
        assertEquals("87902.42", card.getBalance());
    }

    @Test
    void creditCardChargeMoneyZero() {
        Exception e = assertThrows(InvalidActionException.class,
                ()->{
                    CreditCard card = new CreditCard("CreditCard#4", "RUB", "10.30", "10100.79");
                    card.chargeMoney("0");
                });
        assertEquals("The amount subtracted from the balance should be greater than 0.", e.getMessage());
    }

    @Test
    void creditCardChargeMoneyNegative() {
        Exception e = assertThrows(InvalidActionException.class,
                ()->{
                    CreditCard card = new CreditCard("CreditCard#4", "RUB", "10.30", "10100.79");
                    card.chargeMoney("-47.30");
                });
        assertEquals("The amount subtracted from the balance should be greater than 0.", e.getMessage());
    }

    @Test
    void creditCardOvercharge() {
        Exception e = assertThrows(InvalidActionException.class,
                ()->{
                    CreditCard card = new CreditCard("CreditCard#4", "RUB", "10.30", "0.79");
                    card.chargeMoney("0.80");
                });
        assertEquals("The amount subtracted should be less than the balance.", e.getMessage());
    }

    @Test
    void getDebt() throws InvalidActionException {
        CreditCard card = new CreditCard("CreditCard", "RUB", "10.70", "100000.00");
        assertEquals("0.00", card.getDebt());
        card.chargeMoney("15983.14");
        card.chargeMoney("101.00");
        assertEquals("16084.14", card.getDebt());
    }
}