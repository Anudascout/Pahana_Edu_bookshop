package src.business.employee.service;

import src.business.employee.dto.Employeedto;
import src.business.employee.model.EmployeeModel;
import src.business.employee.mapper.EmployeeMapper;
import src.persistance.employee.dao.EmployeeDAO;

public class EmployeeService {
    private EmployeeDAO employeeDAO;

    public EmployeeService() {
        this.employeeDAO = new EmployeeDAO();
    }

    public boolean registerStaff(Employeedto staffDto) {
        EmployeeModel employeeModel = EmployeeMapper.toModel(staffDto);
        return employeeDAO.insertStaff(employeeModel);
    }

    public Employeedto authenticateStaff(String email) {
        EmployeeModel staff = employeeDAO.findByEmail(email);
        return staff != null ? EmployeeMapper.toDto(staff) : null;
    }

}
