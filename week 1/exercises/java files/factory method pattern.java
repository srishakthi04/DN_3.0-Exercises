class Main {
    public static void main(String[] args) {
        DocumentFactory wordFactory = new WordDocumentFactory();
        DocumentFactory pdfFactory = new PdfDocumentFactory();
        DocumentFactory excelFactory = new ExcelDocumentFactory();
        Document wordDoc = wordFactory.createDocument();
        Document pdfDoc = pdfFactory.createDocument();
        Document excelDoc = excelFactory.createDocument();

        wordDoc.open();
        pdfDoc.open();
        excelDoc.open();
    }

public interface Document {
    void open();
}
public class WordDocument implements Document {
    @Override
    public void open() {
        System.out.println("Opening Word doc...");
    }
}
public class PdfDocument implements Document {
    @Override
    public void open() {
        System.out.println("Opening PDF doc...");
    }
}
public class ExcelDocument implements Document {
    @Override
    public void open() {
        System.out.println("Opening Excel doc...");
    }
}
public abstract class DocumentFactory {
    public abstract Document createDocument();
}
public class WordDocumentFactory extends DocumentFactory {
    @Override
    public Document createDocument() {
        return new WordDocument();
    }
}
public class PdfDocumentFactory extends DocumentFactory {
    @Override
    public Document createDocument() {
        return new PdfDocument();
    }
}
public class ExcelDocumentFactory extends DocumentFactory {
    @Override
    public Document createDocument() {
        return new ExcelDocument();
    }
}
}
