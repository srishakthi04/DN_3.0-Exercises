import java.util.HashMap;
class Product {
    private String productId;
    private String productName;
    private int quantity;
    private double price;

    public Product(String productId, String productName, int quantity, double price) {
        this.productId = productId;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
    }
    public String getProductId() { return productId; }
    public void setProductId(String productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    @Override
    public String toString() {
        return 
                "productId='" + productId + '\'' +
                ", productName='" + productName + '\'' +
                ", quantity=" + quantity +
                ", price=" + price;
    }
}
class Inventory {
    private HashMap<String, Product> products;

    public Inventory() {
        products = new HashMap<>();
    }

    public void addProduct(Product product) {
        products.put(product.getProductId(), product);
    }

    public void updateProduct(Product product) {
        products.put(product.getProductId(), product);
    }

    public void deleteProduct(String productId) {
        products.remove(productId);
    }

    public Product getProduct(String productId) {
        return products.get(productId);
    }

    public void displayProducts() {
        for (Product product : products.values()) {
            System.out.println(product);
        }
    }
}

public class Main {
    public static void main(String[] args) {
        Inventory inventory = new Inventory();
        //to add products
        Product product1 = new Product("01", "SmartTV", 5, 30000.99);
        Product product2 = new Product("02", "Speaker", 16, 20000.99);
        inventory.addProduct(product1);
        inventory.addProduct(product2);
        //to display
        System.out.println("All Products:");
        inventory.displayProducts();
        //to update
        product1.setPrice(28000.99);
        inventory.updateProduct(product1);
        // Displaying updated product
        System.out.println("\nUpdated Product:");
        System.out.println(inventory.getProduct("01"));
        //to delete
        inventory.deleteProduct("02");
        System.out.println("\nAll Products after deletion:");
        inventory.displayProducts();
    }
}
