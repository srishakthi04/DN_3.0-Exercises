import java.util.Arrays;
import java.util.Comparator;
class Book {
    int bookId;
    String title;
    String author;
    public Book(int bookId, String title, String author) {
        this.bookId = bookId;
        this.title = title;
        this.author = author;
    }
    public String getTitle() {
        return title;
    }
    @Override
    public String toString() {
        return  
                "bookId=" + bookId +
                ", title='" + title + '\'' +
                ", author='" + author + '\'';
    }
}
public class LibraryManagementSystem {
    public static Book linearSearch(Book[] books, String title) {
        for (Book book : books) {
            if (book.getTitle().equalsIgnoreCase(title)) {
                return book;
            }
        }
        return null;
    }
    public static Book binarySearch(Book[] books, String title) {
        int left = 0;
        int right = books.length - 1;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            int comparison = books[mid].getTitle().compareToIgnoreCase(title);

            if (comparison == 0) {
                return books[mid];
            } else if (comparison < 0) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return null;
    }
    public static void main(String[] args) {
        Book[] books = {
                new Book(1, "Harry Potter", "J. K. Rowling"),
                new Book(2, "1984","george orwell"),
                new Book(3, "diary of a nobody", "George and Weedon Grossmith"),
                new Book(4, "Pride and Prejudice", "Jane Austen")
        };
        Arrays.sort(books, Comparator.comparing(Book::getTitle));
        Book foundBookLinear = linearSearch(books, "diary of a nobody");
        System.out.println("Linear search result: " + foundBookLinear);
        Book foundBookBinary = binarySearch(books, "1984");
        System.out.println("Binary search result: " + foundBookBinary);
    }
}
