package src.business.servlet;

import org.mindrot.jbcrypt.BCrypt;
import src.business.employee.dto.Employeedto;
import src.business.employee.service.EmployeeService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/addstaff")
public class AddEmployeeServlet extends HttpServlet {
    private EmployeeService employeeService;

    @Override
    public void init() throws ServletException {
        employeeService = new EmployeeService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userType = "Staff";

        // ✅ Hash the password before saving
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        Employeedto staffDto = new Employeedto();
        staffDto.setUsername(username);
        staffDto.setEmail(email);
        staffDto.setPassword(hashedPassword);
        staffDto.setUser_type(userType);

        boolean success = employeeService.registerStaff(staffDto);

        if (success) {
            response.sendRedirect("addEmployee.jsp?success=true");
        } else {
            response.sendRedirect("addEmployee.jsp?error=true");
        }
    }
}
