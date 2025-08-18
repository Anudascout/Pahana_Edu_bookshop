package src.business.invoice_item.mapper;

import src.business.invoice_item.dto.InvoiceItemDto;
import src.business.invoice_item.model.InvoiceItemModel;

public class InvoiceItemMapper {

    public static InvoiceItemModel toModel(InvoiceItemDto dto) {
        return new InvoiceItemModel(dto.getId(), dto.getBillId(), dto.getBookId());
    }

    public static InvoiceItemDto toDto(InvoiceItemModel model) {
        return new InvoiceItemDto(model.getId(), model.getBillId(), model.getBookId());
    }
}
