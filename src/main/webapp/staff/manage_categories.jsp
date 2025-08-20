<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="src.business.bookcategory.dto.BookCategoryDto" %>
<%
    List<BookCategoryDto> categories = (List<BookCategoryDto>) request.getAttribute("categories");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Book Categories</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-6">
<div class="max-w-5xl mx-auto bg-white p-6 rounded-lg shadow-md">
    <h2 class="text-2xl font-bold text-gray-800 mb-6">Manage Book Categories</h2>

    <!-- Add Category Form -->
    <div class="mb-6">
        <h3 class="text-lg font-semibold text-gray-700 mb-2">Add New Category</h3>
        <form method="post" action="manage-categories" class="flex flex-col sm:flex-row gap-3">
            <input type="hidden" name="action" value="add">
            <input type="text" name="name" placeholder="Category Name" required
                   class="flex-1 px-3 py-2 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">
            <input type="text" name="description" placeholder="Description"
                   class="flex-1 px-3 py-2 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">
            <button type="submit"
                    class="bg-[#4CAF50] hover:bg-[#45a049] text-white px-4 py-2 rounded text-sm">
                Add
            </button>
        </form>
    </div>

    <!-- Category Table -->
    <div class="overflow-x-auto">
        <table class="w-full border border-gray-200 rounded-lg">
            <thead>
            <tr class="bg-[#4CAF50] text-white">
                <th class="px-4 py-2 text-left">ID</th>
                <th class="px-4 py-2 text-left">Name</th>
                <th class="px-4 py-2 text-left">Description</th>
                <th class="px-4 py-2 text-center">Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (categories != null) {
                    for (BookCategoryDto cat : categories) {
            %>
            <tr class="border-b hover:bg-gray-50">
                <form method="post" action="manage-categories" class="contents">
                    <td class="px-4 py-2"><%= cat.getId() %></td>
                    <td class="px-4 py-2">
                        <input type="text" name="name" value="<%= cat.getName() %>"
                               class="w-full px-2 py-1 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">
                    </td>
                    <td class="px-4 py-2">
                        <input type="text" name="description" value="<%= cat.getDescription() %>"
                               class="w-full px-2 py-1 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">
                    </td>
                    <td class="px-4 py-2 text-center space-x-2">
                        <input type="hidden" name="id" value="<%= cat.getId() %>">

                        <!-- Update Button -->
                        <button type="submit" name="action" value="update"
                                class="bg-[#4CAF50] hover:bg-[#45a049] text-white px-3 py-1 rounded text-sm">
                            Update
                        </button>

                        <!-- Delete Button -->
                        <button type="submit" name="action" value="delete"
                                onclick="return confirm('Delete this category?')"
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
