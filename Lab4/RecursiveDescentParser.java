import java.util.Scanner;


public class RecursiveDescentParser {
    private static String input;
    private static int index;

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter an arithmetic expression: ");
        input = scanner.nextLine();
        index = 0;

        try {
            String result = parseExpression();
            System.out.println("Result: " + result);
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
        finally {
            scanner.close();
        }
    }

    private static String parseExpression() {
        String termValue = parseTerm();
        while (index < input.length() && (input.charAt(index) == '+' || input.charAt(index) == '-')) {
            char operator = input.charAt(index);
            index++;
            String nextTermValue = parseTerm();
            if (operator == '+') {
                termValue += " + "+nextTermValue;
            } else {
                termValue += " - "+nextTermValue;
            }
        }
        return termValue;
    }

    private static String parseTerm() {
        String factorValue = parseFactor();
        while (index < input.length() && (input.charAt(index) == '*' || input.charAt(index) == '/')) {
            char operator = input.charAt(index);
            index++;
            String nextFactorValue = parseFactor();
            if (operator == '*') {
                factorValue += " * " + nextFactorValue;
            } else {
                if (nextFactorValue == "0") {
                    throw new ArithmeticException("Division by zero");
                }
                factorValue += " / " + nextFactorValue;
            }
        }
        return factorValue;
    }

    private static String parseFactor() {
        if (index >= input.length()) {
            throw new IllegalArgumentException("Unexpected end of input");
        }

        char currentChar = input.charAt(index);
        index++;

        if (Character.isDigit(currentChar) || Character.isLeṇtter(currentChar)) {
            return (Character.toString(currentChar));
        } else if (currentChar == '(') {
            String expressionValue = parseExpression();
            if (index >= input.length() || input.charAt(index) != ')') {
                throw new IllegalArgumentException("Expected closing parenthesis");
            }
            index++;
            return expressionValue;
        } else {
            throw new IllegalArgumentException("Invalid character: " + currentChar);
        }
    }
}