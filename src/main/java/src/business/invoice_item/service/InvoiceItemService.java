package src.business.invoice_item.service;



import src.business.invoice_item.dto.InvoiceItemDto;
import src.business.invoice_item.mapper.InvoiceItemMapper;
import src.business.invoice_item.model.InvoiceItemModel;
import src.persistance.invoice_item.dao.Invoice_ItemDAO;

import java.util.List;
import java.util.stream.Collectors;

public class InvoiceItemService {
    private Invoice_ItemDAO invoiceItemDAO;

    public InvoiceItemService() {
        this.invoiceItemDAO = new Invoice_ItemDAO();
    }

    public boolean addBillItem(InvoiceItemDto dto) {
        return invoiceItemDAO.insertBillItem(InvoiceItemMapper.toModel(dto));
    }

    public boolean addBillItems(List<InvoiceItemDto> dtoList) {
        List<InvoiceItemModel> models = dtoList.stream()
                .map(InvoiceItemMapper::toModel)
                .collect(Collectors.toList());

        boolean ok = invoiceItemDAO.insertMultiple(models);
        if (!ok) {
            // Fallback: try inserting one-by-one to better surface errors on some JDBC drivers/DBs
            ok = true;
            for (InvoiceItemModel m : models) {
                if (!invoiceItemDAO.insertBillItem(m)) {
                    ok = false;
                    break;
                }
            }
        }
        return ok;
    }

    public List<InvoiceItemDto> getItemsByBillId(int billId) {
        return invoiceItemDAO.getItemsByBillId(billId).stream()
                .map(InvoiceItemMapper::toDto)
                .collect(Collectors.toList());
    }
}
