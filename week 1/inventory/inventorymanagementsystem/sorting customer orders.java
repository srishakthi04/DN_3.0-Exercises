import java.util.Arrays;
public class sortingcustomerorders {
    public static void main(String[] args) {
        Order[] orders = {
            new Order(1, "Alwin", 256.0),
            new Order(2, "shakthi", 140.0),
            new Order(3, "moni", 330.0),
            new Order(4, "raj", 258.0),
            new Order(5, "siva", 160.0)
        };

        // Bubble Sort
        bubbleSort(orders);
        System.out.println("Bubble Sort Result:");
        printOrders(orders);
        // Quick Sort
        quickSort(orders, 0, orders.length - 1);
        System.out.println("Quick Sort Result:");
        printOrders(orders);
    }
    public static void bubbleSort(Order[] orders) {
        int n = orders.length;
        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (orders[j].totalPrice > orders[j + 1].totalPrice) {
                    Order temp = orders[j];
                    orders[j] = orders[j + 1];
                    orders[j + 1] = temp;
                }
            }
        }
    }
    public static void quickSort(Order[] orders, int low, int high) {
        if (low < high) {
            int pi = partition(orders, low, high);
            quickSort(orders, low, pi - 1);
            quickSort(orders, pi + 1, high);
        }
    }
    public static int partition(Order[] orders, int low, int high) {
        double pivot = orders[high].totalPrice;
        int i = (low - 1);
        for (int j = low; j < high; j++) {
            if (orders[j].totalPrice <= pivot) {
                i++;
                Order temp = orders[i];
                orders[i] = orders[j];
                orders[j] = temp;
            }
        }
        Order temp = orders[i + 1];
        orders[i + 1] = orders[high];
        orders[high] = temp;
        return i + 1;
    }
    public static void printOrders(Order[] orders) {
        for (Order order : orders) {
            System.out.println(order);
        }
    }
}
class Order {
    int orderId;
    String customerName;
    double totalPrice;

    public Order(int orderId, String customerName, double totalPrice) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.totalPrice = totalPrice;
    }
    @Override
    public String toString() {
        return "orderId=" + orderId + ", customerName=" + customerName + ", totalPrice=" + totalPrice;
    }
}
