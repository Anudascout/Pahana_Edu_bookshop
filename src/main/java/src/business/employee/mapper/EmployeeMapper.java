package src.business.employee.mapper;

import src.business.employee.dto.Employeedto;
import src.business.employee.model.EmployeeModel;

public class EmployeeMapper {
    public static EmployeeModel toModel(Employeedto dto) {
        return new EmployeeModel(dto.getId(), dto.getUsername(), dto.getEmail(), dto.getPassword(), dto.getUser_type());
    }

    public static Employeedto toDto(EmployeeModel model) {
        return new Employeedto(model.getId(), model.getUsername(), model.getEmail(), model.getPassword(), model.getUser_type());
    }
}
