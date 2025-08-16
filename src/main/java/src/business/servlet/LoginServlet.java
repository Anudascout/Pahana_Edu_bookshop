package src.business.servlet;

import src.business.employee.service.EmployeeService;
import src.business.employee.dto.Employeedto;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final String hardcodedEmail = "admin@gmail.com";
    private final String hardcodedPassword = "123456";
    private EmployeeService employeeService;

    @Override
    public void init() throws ServletException {
        employeeService = new EmployeeService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Admin login (hardcoded)
        if (email.equals(hardcodedEmail) && password.equals(hardcodedPassword)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", "admin");
            session.setAttribute("username", "Administrator"); 
            response.sendRedirect("admin/adminpanel.jsp");
            return;
        }

        // Staff login with hashed password
        Employeedto staff = employeeService.authenticateStaff(email);
        if (staff != null && "Staff".equalsIgnoreCase(staff.getUser_type())) {
            // Verify hashed password
            if (BCrypt.checkpw(password, staff.getPassword())) {
                HttpSession session = request.getSession();
                session.setAttribute("staff", "Staff"); 
                session.setAttribute("username", staff.getUsername()); 
                // Store staffId for billing
                session.setAttribute("staffId", staff.getId());
                // Optionally store email
                session.setAttribute("staffEmail", staff.getEmail());
                response.sendRedirect("staff/staffpanel.jsp");
                return;
            }
        }

        // If login fails
        response.sendRedirect("login.jsp?error=invalid");
    }
}
