package com.interview.enums;

public enum Position {
    MANAGER("Manager"),
    DEVELOPER("Developer"),
    TESTER("Tester"),
    DESIGNER("Designer");

    private final String displayValue;

    Position(String displayValue) {
        this.displayValue = displayValue;
    }

    public String getDisplayValue() {
        return displayValue;
    }
}
