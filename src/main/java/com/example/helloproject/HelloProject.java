package com.example.helloproject;

public final class HelloProject {
    private HelloProject() {
    }

    public static String greeting() {
        return "Hello, World!";
    }

    public static void main(String[] args) {
        System.out.println(greeting());
    }
}
