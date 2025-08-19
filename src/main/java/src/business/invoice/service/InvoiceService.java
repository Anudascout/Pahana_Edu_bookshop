package src.business.invoice.service;

import src.business.invoice.dto.InvoiceDto;
import src.business.invoice.mapper.InvoiceMapper;
import src.persistance.invoice.dao.InvoiceDAO;

import java.util.List;
import java.util.stream.Collectors;

public class InvoiceService {
    private InvoiceDAO invoiceDAO;

    public InvoiceService() {
        this.invoiceDAO = new InvoiceDAO();
    }

    public int createBill(InvoiceDto dto) {
        return invoiceDAO.insertBill(InvoiceMapper.toModel(dto));
    }

    public List<InvoiceDto> getAllBills() {
        return invoiceDAO.getAllBills().stream()
                .map(InvoiceMapper::toDto)
                .collect(Collectors.toList());
    }
}



