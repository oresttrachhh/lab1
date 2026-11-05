package com.example.helloproject;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class BasicAdditionTest {
    @Test
    void addsTwoNumbers() {
        assertEquals(7, BasicAddition.add(3, 4));
    }
}
