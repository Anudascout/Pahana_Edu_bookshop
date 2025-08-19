<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="java.sql.*" %>
<%@ page import="src.business.db.DBConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Manage Staff - Pahana Edu Admin</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-[#F5F7FA] font-sans">

<!-- Header -->
<header class="bg-[#E74C3C] text-white p-4 shadow-md flex justify-between items-center">
    <h1 class="text-xl font-bold">Pahana Edu - Staff Management</h1>
    <div class="flex items-center space-x-4">
        <span class="font-medium">Welcome, ${sessionScope.username}</span>
        <a href="${pageContext.request.contextPath}/admin/adminpanel.jsp" 
           class="bg-[#C0392B] hover:bg-[#A93226] px-3 py-1 rounded text-sm transition">
            Back to Dashboard
        </a>
    </div>
</header>

<!-- Main Content -->
<div class="container mx-auto px-6 py-8">
    
    <!-- Page Title -->
    <div class="mb-8">
        <h2 class="text-2xl font-bold text-[#2C3E50] mb-2">Staff Management</h2>
        <p class="text-gray-600">View and manage all staff members in the system</p>
    </div>

    <!-- Quick Actions -->
    <div class="mb-8">
        <a href="${pageContext.request.contextPath}/admin/adminpanel.jsp#addEmployeeForm" 
           class="bg-[#E74C3C] hover:bg-[#C0392B] text-white px-4 py-2 rounded-lg transition inline-flex items-center">
            <span class="mr-2">➕</span>
            Add New Employee
        </a>
    </div>

    <!-- Staff List -->
    <div class="bg-white rounded-lg shadow-md overflow-hidden">
        <div class="px-6 py-4 bg-[#F8F9FA] border-b border-[#E0E0E0]">
            <h3 class="text-lg font-semibold text-[#2C3E50]">All Staff Members</h3>
        </div>
        
        <div class="overflow-x-auto">
            <table class="w-full">
                <thead class="bg-[#F1F2F6]">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-[#2C3E50] uppercase tracking-wider">ID</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-[#2C3E50] uppercase tracking-wider">Username</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-[#2C3E50] uppercase tracking-wider">Email</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-[#2C3E50] uppercase tracking-wider">Full Name</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-[#2C3E50] uppercase tracking-wider">Phone</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-[#2C3E50] uppercase tracking-wider">Status</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-[#2C3E50] uppercase tracking-wider">Actions</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-[#E0E0E0]">
                    <%
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;
                        
                        try {
                            conn = DBConnection.getConnection();
                            String sql = "SELECT user_id, username, email, full_name, phone, status FROM users WHERE user_type = 'Staff' ORDER BY user_id DESC";
                            pstmt = conn.prepareStatement(sql);
                            rs = pstmt.executeQuery();
                            
                            boolean hasStaff = false;
                            while (rs.next()) {
                                hasStaff = true;
                                int userId = rs.getInt("user_id");
                                String username = rs.getString("username");
                                String email = rs.getString("email");
                                String fullName = rs.getString("full_name");
                                String phone = rs.getString("phone");
                                String status = rs.getString("status");
                    %>
                    <tr class="hover:bg-[#F8F9FA] transition">
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-[#2C3E50]">
                            <span class="font-medium">#<%= userId %></span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-[#2C3E50]">
                            <div class="flex items-center">
                                <div class="flex-shrink-0 h-8 w-8 bg-[#E74C3C] rounded-full flex items-center justify-center text-white text-xs font-bold">
                                    <%= username.substring(0, 1).toUpperCase() %>
                                </div>
                                <div class="ml-3">
                                    <span class="font-medium"><%= username %></span>
                                </div>
                            </div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-[#2C3E50]">
                            <%= email %>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-[#2C3E50]">
                            <%= fullName != null ? fullName : "-" %>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-[#2C3E50]">
                            <%= phone != null ? phone : "-" %>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <% if ("active".equalsIgnoreCase(status)) { %>
                                <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-[#D5EDDA] text-[#155724]">
                                    Active
                                </span>
                            <% } else { %>
                                <span class="inline-flex px-2 py-1 text-xs font-semibold rounded-full bg-[#F8D7DA] text-[#721C24]">
                                    Inactive
                                </span>
                            <% } %>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                            <div class="flex space-x-2">
                                <button onclick="editStaff(<%= userId %>, '<%= username %>', '<%= email %>', '<%= fullName != null ? fullName : "" %>', '<%= phone != null ? phone : "" %>')"
                                        class="text-[#3498DB] hover:text-[#2980B9] transition">
                                    Edit
                                </button>
                                <% if ("active".equalsIgnoreCase(status)) { %>
                                    <button onclick="toggleStaffStatus(<%= userId %>, 'inactive')"
                                            class="text-[#E67E22] hover:text-[#D35400] transition">
                                        Deactivate
                                    </button>
                                <% } else { %>
                                    <button onclick="toggleStaffStatus(<%= userId %>, 'active')"
                                            class="text-[#27AE60] hover:text-[#229954] transition">
                                        Activate
                                    </button>
                                <% } %>
                                <button onclick="deleteStaff(<%= userId %>, '<%= username %>')"
                                        class="text-[#E74C3C] hover:text-[#C0392B] transition">
                                    Delete
                                </button>
                            </div>
                        </td>
                    </tr>
                    <%
                            }
                            
                            if (!hasStaff) {
                    %>
                    <tr>
                        <td colspan="7" class="px-6 py-8 text-center text-gray-500">
                            <div class="flex flex-col items-center">
                                <div class="text-4xl mb-4">👥</div>
                                <p class="text-lg font-medium mb-2">No staff members found</p>
                                <p class="text-sm">Add your first employee to get started</p>
                                <a href="${pageContext.request.contextPath}/admin/adminpanel.jsp#addEmployeeForm" 
                                   class="mt-4 bg-[#E74C3C] hover:bg-[#C0392B] text-white px-4 py-2 rounded-lg transition">
                                    Add Employee
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                    %>
                    <tr>
                        <td colspan="7" class="px-6 py-8 text-center text-red-600">
                            <div class="flex flex-col items-center">
                                <div class="text-4xl mb-4">⚠️</div>
                                <p class="text-lg font-medium mb-2">Error loading staff data</p>
                                <p class="text-sm">Please try refreshing the page or contact support</p>
                            </div>
                        </td>
                    </tr>
                    <%
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Edit Staff Modal -->
<div id="editModal" class="fixed inset-0 bg-black bg-opacity-50 hidden items-center justify-center z-50">
    <div class="bg-white rounded-lg p-6 w-full max-w-md mx-4">
        <h3 class="text-lg font-semibold text-[#2C3E50] mb-4">Edit Staff Member</h3>
        <form id="editForm" method="post" action="${pageContext.request.contextPath}/updatestaff">
            <input type="hidden" id="editUserId" name="userId">
            
            <div class="mb-4">
                <label class="block text-[#2C3E50] font-medium mb-1">Username</label>
                <input type="text" id="editUsername" name="username" required
                       class="w-full px-4 py-2 border border-[#E0E0E0] rounded-lg focus:outline-none focus:ring-2 focus:ring-[#E74C3C] focus:border-transparent">
            </div>
            
            <div class="mb-4">
                <label class="block text-[#2C3E50] font-medium mb-1">Email</label>
                <input type="email" id="editEmail" name="email" required
                       class="w-full px-4 py-2 border border-[#E0E0E0] rounded-lg focus:outline-none focus:ring-2 focus:ring-[#E74C3C] focus:border-transparent">
            </div>
            
            <div class="mb-4">
                <label class="block text-[#2C3E50] font-medium mb-1">Full Name</label>
                <input type="text" id="editFullName" name="fullName"
                       class="w-full px-4 py-2 border border-[#E0E0E0] rounded-lg focus:outline-none focus:ring-2 focus:ring-[#E74C3C] focus:border-transparent">
            </div>
            
            <div class="mb-6">
                <label class="block text-[#2C3E50] font-medium mb-1">Phone</label>
                <input type="tel" id="editPhone" name="phone"
                       class="w-full px-4 py-2 border border-[#E0E0E0] rounded-lg focus:outline-none focus:ring-2 focus:ring-[#E74C3C] focus:border-transparent">
            </div>
            
            <div class="flex space-x-3">
                <button type="submit" class="flex-1 bg-[#E74C3C] hover:bg-[#C0392B] text-white py-2 rounded-lg transition">
                    Update
                </button>
                <button type="button" onclick="closeEditModal()" class="flex-1 bg-gray-500 hover:bg-gray-600 text-white py-2 rounded-lg transition">
                    Cancel
                </button>
            </div>
        </form>
    </div>
</div>

<script>
function editStaff(userId, username, email, fullName, phone) {
    document.getElementById('editUserId').value = userId;
    document.getElementById('editUsername').value = username;
    document.getElementById('editEmail').value = email;
    document.getElementById('editFullName').value = fullName;
    document.getElementById('editPhone').value = phone;
    document.getElementById('editModal').classList.remove('hidden');
    document.getElementById('editModal').classList.add('flex');
}

function closeEditModal() {
    document.getElementById('editModal').classList.add('hidden');
    document.getElementById('editModal').classList.remove('flex');
}

function toggleStaffStatus(userId, newStatus) {
    if (confirm('Are you sure you want to ' + newStatus + ' this staff member?')) {
        window.location.href = '${pageContext.request.contextPath}/togglestaffstatus?userId=' + userId + '&status=' + newStatus;
    }
}

function deleteStaff(userId, username) {
    if (confirm('Are you sure you want to delete staff member "' + username + '"? This action cannot be undone.')) {
        window.location.href = '${pageContext.request.contextPath}/deletestaff?userId=' + userId;
    }
}

// Close modal when clicking outside
document.getElementById('editModal').addEventListener('click', function(e) {
    if (e.target === this) {
        closeEditModal();
    }
});
</script>

</body>
</html>
