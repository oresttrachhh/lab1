package com.example.helloproject;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class HelloProjectTest {
    @Test
    void greetingReturnsHelloWorld() {
        assertEquals("Hello, World!", HelloProject.greeting());
    }
}
