package src.business.invoice_item.model;

public class InvoiceItemModel {
    private int id;
    private int billId;
    private int bookId;

    public InvoiceItemModel() {}

    public InvoiceItemModel(int id, int billId, int bookId) {
        this.id = id;
        this.billId = billId;
        this.bookId = bookId;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
}
