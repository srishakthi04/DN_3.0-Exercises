
import java.util.Arrays;
public class ECommerceSearch {
    public static void main(String[] args) {
        Product[] products = {
            new Product(1, "Laptop", "Electronics"),
            new Product(2, "Shirt", "Clothing"),
            new Product(3, "Book", "Books"),
            new Product(4, "Phone", "Electronics"),
            new Product(5, "Shoes", "Footwear")
        };
        // Linear Search
        Product result = linearSearch(products, "Phone");
        System.out.println("Linear Search Result: " + result);

        // Binary Search
        Arrays.sort(products, (p1, p2) -> p1.productName.compareTo(p2.productName));
        result = binarySearch(products, "Phone");
        System.out.println("Binary Search Result: " + result);
    }
    public static Product linearSearch(Product[] products, String productName) {
        for (Product product : products) {
            if (product.productName.equals(productName)) {
                return product;
            }
        }
        return null;
    }
    public static Product binarySearch(Product[] products, String productName) {
        int left = 0, right = products.length - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            int result = productName.compareTo(products[mid].productName);
            if (result == 0) {
                return products[mid];
            }
            if (result > 0) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null;
    }
}
class Product {
    int productId;
    String productName;
    String category;
    public Product(int productId, String productName, String category) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }
    @Override
    public String toString() {
        return "productId=" + productId + ", productName=" + productName + ", category=" + category ;
    }
}
