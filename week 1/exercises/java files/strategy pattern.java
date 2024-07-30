
interface PaymentStrategy {
    void pay(int amount);
}
class CreditCardPayment implements PaymentStrategy {
    private String cardNumber;
    public CreditCardPayment(String cardNumber) {
        this.cardNumber = cardNumber;
    }
    @Override
    public void pay(int amount) {
        System.out.println("Paid " + amount + " using Debit Card with number: " + cardNumber);
    }
}
class PayPalPayment implements PaymentStrategy {
    private String email;
    public PayPalPayment(String email) {
        this.email = email;
    }
    @Override
    public void pay(int amount) {
        System.out.println("Paid " + amount + " using Googlepay with email: " + email);
    }
}
class PaymentContext {
    private PaymentStrategy paymentStrategy;

    public void setPaymentStrategy(PaymentStrategy paymentStrategy) {
        this.paymentStrategy = paymentStrategy;
    }
    public void executePayment(int amount) {
        paymentStrategy.pay(amount);
    }
}
public class StrategyPatternExample {
    public static void main(String[] args) {
        PaymentContext context = new PaymentContext();

        context.setPaymentStrategy(new CreditCardPayment("1234-5678-9012-3456"));
        context.executePayment(1500);
        context.setPaymentStrategy(new PayPalPayment("userid@example.com"));
        context.executePayment(850);
    }
}
