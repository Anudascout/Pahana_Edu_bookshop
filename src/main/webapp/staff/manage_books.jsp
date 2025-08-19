<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="src.business.book.dto.BookDto" %>
<%@ page import="src.business.bookcategory.dto.BookCategoryDto" %>
<%
    List<BookDto> books = (List<BookDto>) request.getAttribute("books");
    List<BookCategoryDto> categories = (List<BookCategoryDto>) request.getAttribute("categories");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Books</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-6">
<div class="max-w-7xl mx-auto bg-white p-6 rounded-lg shadow-md">
    <h2 class="text-2xl font-bold text-gray-800 mb-6">Manage Books</h2>

    <!-- Add Book Form -->
    <div class="mb-6">
        <h3 class="text-lg font-semibold text-gray-700 mb-2">Add New Book</h3>
        <form method="post" action="manage-books" enctype="multipart/form-data"
              class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
            <input type="hidden" name="action" value="add">

            <!-- Category -->
            <select name="category_id" required
                    class="px-3 py-2 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">
                <option value="">-- Select Category --</option>
                <% for (BookCategoryDto cat : categories) { %>
                <option value="<%= cat.getId() %>"><%= cat.getName() %></option>
                <% } %>
            </select>

            <!-- Name -->
            <input type="text" name="name" placeholder="Book Name" required
                   class="px-3 py-2 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">

            <!-- Description -->
            <input type="text" name="description" placeholder="Description"
                   class="px-3 py-2 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">

            <!-- Price -->
            <input type="number" step="0.01" name="price" placeholder="Price" required
                   class="px-3 py-2 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">

            <!-- Quantity -->
            <input type="number" name="qty" value="1" min="0" required
                   class="px-3 py-2 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">

            <!-- Photo -->
            <input type="file" name="photo"
                   class="px-3 py-2 border border-gray-300 rounded bg-gray-50 text-sm">

            <!-- Submit -->
            <button type="submit"
                    class="bg-[#4CAF50] hover:bg-[#45a049] text-white px-4 py-2 rounded text-sm">
                Add
            </button>
        </form>
    </div>

    <!-- Books Table -->
    <div class="overflow-x-auto">
        <table class="w-full border border-gray-200 rounded-lg">
            <thead>
            <tr class="bg-[#4CAF50] text-white">
                <th class="px-4 py-2 text-left">ID</th>
                <th class="px-4 py-2 text-left">Category</th>
                <th class="px-4 py-2 text-left">Name</th>
                <th class="px-4 py-2 text-left">Description</th>
                <th class="px-4 py-2 text-left">Price</th>
                <th class="px-4 py-2 text-left">Qty</th>
                <th class="px-4 py-2 text-left">Photo</th>
                <th class="px-4 py-2 text-center">Actions</th>
            </tr>
            </thead>
            <tbody>
            <% if (books != null) {
                for (BookDto book : books) { %>
            <tr class="border-b hover:bg-gray-50">
                <form method="post" action="manage-books" enctype="multipart/form-data" class="contents">
                    <td class="px-4 py-2"><%= book.getId() %></td>

                    <!-- Category -->
                    <td class="px-4 py-2">
                        <select name="category_id"
                                class="w-full px-2 py-1 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">
                            <% for (BookCategoryDto cat : categories) { %>
                            <option value="<%= cat.getId() %>" <%= (cat.getId() == book.getCategoryId() ? "selected" : "") %>>
                                <%= cat.getName() %>
                            </option>
                            <% } %>
                        </select>
                    </td>

                    <!-- Name -->
                    <td class="px-4 py-2">
                        <input type="text" name="name" value="<%= book.getName() %>"
                               class="w-full px-2 py-1 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">
                    </td>

                    <!-- Description -->
                    <td class="px-4 py-2">
                        <input type="text" name="description" value="<%= book.getDescription() %>"
                               class="w-full px-2 py-1 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">
                    </td>

                    <!-- Price -->
                    <td class="px-4 py-2">
                        <input type="number" step="0.01" name="price" value="<%= book.getPrice() %>"
                               class="w-full px-2 py-1 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">
                    </td>

                    <!-- Qty -->
                    <td class="px-4 py-2">
                        <input type="number" name="qty" value="<%= book.getQty() %>" min="0"
                               class="w-full px-2 py-1 border border-gray-300 rounded focus:ring-2 focus:ring-[#4CAF50] text-sm">
                    </td>

                    <!-- Photo -->
                    <td class="px-4 py-2 space-y-2">
                        <% if (book.getPhoto() != null && !book.getPhoto().isEmpty()) { %>
                        <img src="<%= book.getPhoto() %>" class="w-16 h-16 object-cover rounded border">
                        <% } %>
                        <input type="file" name="photo"
                               class="w-full px-2 py-1 border border-gray-300 rounded bg-gray-50 text-sm">
                        <input type="hidden" name="existingPhoto" value="<%= book.getPhoto() %>">
                    </td>

                    <!-- Actions -->
                    <td class="px-4 py-2 text-center space-x-2">
                        <input type="hidden" name="id" value="<%= book.getId() %>">

                        <button type="submit" name="action" value="update"
                                class="bg-[#4CAF50] hover:bg-[#45a049] text-white px-3 py-1 rounded text-sm">
                            Update
                        </button>

                        <button type="submit" name="action" value="delete"
                                onclick="return confirm('Are you sure?')"
                                class="bg-red-500 hover:bg-red-600 text-white px-3 py-1 rounded text-sm">
                            Delete
                        </button>
                    </td>
                </form>
            </tr>
            <% }} %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
