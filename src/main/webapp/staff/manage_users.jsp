<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="src.business.user.dto.Userdto" %>
<%
    List<Userdto> users = (List<Userdto>) request.getAttribute("users");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Users</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-6">
<div class="max-w-6xl mx-auto bg-white p-6 rounded-lg shadow-md">
    <h2 class="text-2xl font-bold text-gray-800 mb-6">Manage Users</h2>

    <div class="overflow-x-auto">
        <table class="w-full border border-gray-200 rounded-lg">
            <thead>
            <tr class="bg-[#4CAF50] text-white">
                <th class="px-4 py-2 text-left">ID</th>
                <th class="px-4 py-2 text-left">Account</th>
                <th class="px-4 py-2 text-left">Name</th>
                <th class="px-4 py-2 text-left">Address</th>
                <th class="px-4 py-2 text-left">Telephone</th>
                <th class="px-4 py-2 text-left">Email</th>
                <th class="px-4 py-2 text-center">Units Consumed</th>
                <th class="px-4 py-2 text-center">Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (users != null) {
                    for (Userdto user : users) {
            %>
            <tr class="border-b hover:bg-gray-50">
                <form action="manage-users" method="post" class="contents">
                    <td class="px-4 py-2"><%= user.getId() %></td>
                    <td class="px-4 py-2"><%= user.getAccount_number() %></td>
                    <td class="px-4 py-2">
                        <input type="text" name="name" value="<%= user.getName() %>"
                               class="w-full px-2 py-1 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">
                    </td>
                    <td class="px-4 py-2">
                        <input type="text" name="address" value="<%= user.getAddress() %>"
                               class="w-full px-2 py-1 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">
                    </td>
                    <td class="px-4 py-2">
                        <input type="text" name="telephone" value="<%= user.getTelephone() %>"
                               class="w-full px-2 py-1 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">
                    </td>
                    <td class="px-4 py-2">
                        <input type="email" name="email" value="<%= user.getEmail() %>"
                               class="w-full px-2 py-1 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">
                    </td>
                    <td class="px-4 py-2 text-center"><%= user.getUnitsConsumed() %></td>
                    <td class="px-4 py-2 text-center space-x-2">
                        <input type="hidden" name="id" value="<%= user.getId() %>">
                        <input type="hidden" name="user_type" value="<%= user.getUser_type() %>">

                        <!-- Update Button -->
                        <button type="submit" name="action" value="update"
                                class="bg-[#4CAF50] hover:bg-[#45a049] text-white px-3 py-1 rounded text-sm">
                            Update
                        </button>

                        <!-- Delete Button -->
                        <button type="submit" name="action" value="delete"
                                onclick="return confirm('Delete this user?')"
                                class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded text-sm">
                            Delete
                        </button>
                    </td>
                </form>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
