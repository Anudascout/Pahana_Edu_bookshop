package src.business.invoice.mapper;

import src.business.invoice.dto.InvoiceDto;
import src.business.invoice.model.InvoiceModel;

public class InvoiceMapper {
    public static InvoiceModel toModel(InvoiceDto dto) {
        return new InvoiceModel(
                dto.getId(),
                dto.getUserId(),
                dto.getStaffId(),
                dto.getDate(),
                dto.getDiscount(),
                dto.getQty(),
                dto.getTotal(),
                dto.getPaid(),
                dto.getBalance(),
                dto.getChange()
        );
    }




    public static InvoiceDto toDto(InvoiceModel model) {
        return new InvoiceDto(
                model.getId(),
                model.getUserId(),
                model.getStaffId(),
                model.getDate(),
                model.getDiscount(),
                model.getQty(),
                model.getTotal(),
                model.getPaid(),
                model.getBalance(),
                model.getChange()
        );
    }
}
