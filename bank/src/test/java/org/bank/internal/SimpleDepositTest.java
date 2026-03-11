package org.bank.internal;

import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

/*
 * AbstractMoneyAccount superclass is covered in CreditCardTest.
 * AbstractDeposit superclass is covered here.
 */
class SimpleDepositTest {

    @Test
    void simpleDepositIsOpen() throws InvalidActionException {
        SimpleDeposit deposit = new SimpleDeposit("3myfirstdeposit-1", "RUB");
        assertTrue(deposit.isOpen);
    }

    @Test
    void simpleDepositAddMoney() throws InvalidActionException {
        SimpleDeposit deposit = new SimpleDeposit("deposit", "RUB");
        deposit.addMoney("1046.14");
        deposit.addMoney("164.79");
        assertEquals("1210.93", deposit.getBalance());
    }

    @Test
    void simpleDepositAddMoneyZero() {
        Exception e = assertThrows(InvalidActionException.class,
                ()->{
                    SimpleDeposit deposit = new SimpleDeposit("deposit", "RUB");
                    deposit.addMoney("0.00");
                });
        assertEquals("The amount added to the balance should be greater than 0.", e.getMessage());
    }

    @Test
    void simpleDepositAddMoneyNegative() {
        Exception e = assertThrows(InvalidActionException.class,
                ()->{
                    SimpleDeposit deposit = new SimpleDeposit("deposit", "RUB");
                    deposit.addMoney("-100.23");
                });
        assertEquals("The amount added to the balance should be greater than 0.", e.getMessage());
    }

    @Test
    void simpleDepositGetBalance() throws InvalidActionException {
        SimpleDeposit deposit = new SimpleDeposit("deposit", "RUB");
        deposit.addMoney("999.89");
        deposit.addMoney("000.11");
        assertEquals("1000.00", deposit.getBalance());
    }

    @Test
    void simpleDepositClose() throws InvalidActionException {
        SimpleDeposit deposit = new SimpleDeposit("3myfirstdeposit-1", "RUB");
        deposit.close();
        assertFalse(deposit.isOpen);

        Exception e1 = assertThrows(InvalidActionException.class,
                ()-> deposit.addMoney("1024.00"));
        assertEquals("The account is closed.", e1.getMessage());

        Exception e2 = assertThrows(InvalidActionException.class,
                deposit::getBalance);
        assertEquals("The account is closed.", e2.getMessage());
    }

    @Test
    void simpleDepositCloseNotZeroBalance() throws InvalidActionException {
        SimpleDeposit deposit = new SimpleDeposit("3myfirstdeposit-1", "RUB");
        deposit.addMoney("0.01");
        Exception e = assertThrows(InvalidActionException.class,
                deposit::close);
        assertEquals("The balance is not 0.", e.getMessage());

        assertTrue(deposit.isOpen);
    }
}
