<%@ page import="java.util.List" %>
<%@ page import="src.persistance.book.dao.BookDAO" %>
<%@ page import="src.business.book.model.BookModel" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>

<%
    if (session.getAttribute("cart") == null) {
        session.setAttribute("cart", new HashMap<Integer, Integer>());
    }

    if (request.getParameter("addToCart") != null) {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");

        BookDAO _bookDAO = new BookDAO();
        BookModel _book = _bookDAO.getBookById(bookId);
        if (_book != null) {
            int inCart = cart.getOrDefault(bookId, 0);
            int available = _book.getQty() - inCart;
            if (available <= 0 || quantity > available) {
                request.setAttribute("message", "Insufficient stock for '" + _book.getName() + "'. Requested " + quantity + ", available " + Math.max(available, 0) + ".");
            } else {
                cart.put(bookId, inCart + quantity);
                session.setAttribute("cart", cart);
                request.setAttribute("message", "Added " + quantity + " x '" + _book.getName() + "' to cart.");
            }
        }
    }

    String searchTerm = request.getParameter("searchTerm");
    BookDAO bookDAO = new BookDAO();
    List<BookModel> bookList = bookDAO.getAllBooks();

    if (searchTerm != null && !searchTerm.isEmpty()) {
        try {
            int searchId = Integer.parseInt(searchTerm);
            bookList.removeIf(book -> book.getId() != searchId);
        } catch (NumberFormatException e) {
            String searchLower = searchTerm.toLowerCase();
            bookList.removeIf(book -> !book.getName().toLowerCase().contains(searchLower));
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Select Books</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 p-6">
<div class="max-w-6xl mx-auto bg-white p-6 rounded-lg shadow-md">
    <h1 class="text-2xl font-bold text-gray-800 mb-4">Available Books</h1>

    <% if (request.getAttribute("message") != null) { %>
    <div class="bg-yellow-100 border border-yellow-300 text-yellow-800 px-4 py-2 rounded mb-4">
        <%= request.getAttribute("message") %>
    </div>
    <% } %>

    <!-- Search Form -->
    <div class="bg-gray-50 p-4 rounded-md mb-6">
        <form method="get" action="" class="flex items-center">
            <input type="text"
                   name="searchTerm"
                   placeholder="Search by ID or Book Name"
                   value="<%= searchTerm != null ? searchTerm : "" %>"
                   class="px-3 py-2 border border-gray-300 rounded-md w-80 mr-3 text-sm focus:outline-none focus:ring-2 focus:ring-[#4CAF50]"
                   aria-label="Search books">
            <button type="submit" class="bg-[#4CAF50] hover:bg-[#45a049] text-white px-4 py-2 rounded-md text-sm">Search</button>
            <% if (searchTerm != null && !searchTerm.isEmpty()) { %>
            <a href="select_books.jsp" class="ml-3 text-gray-500 text-sm hover:underline">Clear Search</a>
            <% } %>
        </form>
    </div>

    <!-- Books Table -->
    <div class="overflow-x-auto">
        <table class="w-full border border-gray-200">
            <thead>
            <tr class="bg-[#4CAF50] text-white">
                <th class="px-4 py-2 text-left">ID</th>
                <th class="px-4 py-2 text-left">Name</th>
                <th class="px-4 py-2 text-left">Description</th>
                <th class="px-4 py-2 text-left">Price (Rs.)</th>
                <th class="px-4 py-2 text-left">Available</th>
                <th class="px-4 py-2 text-left">Quantity</th>
                <th class="px-4 py-2 text-left">Action</th>
            </tr>
            </thead>
            <tbody>
            <% if (bookList != null && !bookList.isEmpty()) {
                for (BookModel book : bookList) {
            %>
            <tr class="border-b hover:bg-gray-100" data-book-id="<%= book.getId() %>" data-available="<%= book.getQty() %>">
                <td class="px-4 py-2"><%= book.getId() %></td>
                <td class="px-4 py-2"><%= book.getName() %></td>
                <td class="px-4 py-2"><%= book.getDescription() %></td>
                <td class="px-4 py-2"><%= String.format("%.2f", book.getPrice()) %></td>
                <td class="px-4 py-2">
                    <%= book.getQty() %>
                    <% if (book.getQty() <= 0) { %>
                    <div class="text-xs text-gray-500">Out of stock</div>
                    <% } %>
                </td>
                <td class="px-4 py-2">
                    <input type="number"
                           class="w-16 px-2 py-1 border border-gray-300 rounded text-center quantity-input"
                           name="quantity"
                           min="1"
                           max="<%= book.getQty() %>"
                           value="1" <%= book.getQty() <= 0 ? "disabled" : "" %>>
                </td>
                <td class="px-4 py-2">
                    <form method="post" action="" class="add-to-cart-form">
                        <input type="hidden" name="bookId" value="<%= book.getId() %>">
                        <input type="hidden" name="quantity" value="1" class="quantity-field">
                        <button type="submit" name="addToCart"
                                class="bg-blue-500 hover:bg-blue-600 text-white px-3 py-1 rounded text-sm <%= book.getQty() <= 0 ? "opacity-50 cursor-not-allowed" : "" %>"
                                <%= book.getQty() <= 0 ? "disabled" : "" %>>
                            Add to Cart
                        </button>
                    </form>
                </td>
            </tr>
            <% }
            } else { %>
            <tr>
                <td colspan="7" class="text-center py-6 text-gray-500">
                    No books found matching your criteria.
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <!-- Cart Summary -->
    <div class="mt-6 bg-green-50 p-4 rounded-md">
        <h3 class="font-bold text-gray-800 mb-2">Your Cart</h3>
        <%
            @SuppressWarnings("unchecked")
            Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
            if (cart != null && !cart.isEmpty()) {
        %>
        <p class="mb-2">You have <%= cart.size() %> item(s) in your cart.</p>
        <a href="view_cart.jsp" class="text-blue-600 hover:underline mr-4">View Cart</a>
        <a href="<%= request.getContextPath() %>/checkout?customerId=<%= request.getParameter("customerId") %>"
           class="text-blue-600 hover:underline">Proceed to Checkout</a>
        <% } else { %>
        <p class="text-gray-600">Your cart is empty.</p>
        <% } %>
    </div>
</div>

<script>
    document.querySelectorAll('.quantity-input').forEach(input => {
        input.addEventListener('change', function() {
            const max = parseInt(this.getAttribute('max')) || 1;
            let val = parseInt(this.value) || 1;
            if (val < 1) val = 1;
            if (val > max) val = max;
            this.value = val;
            const form = this.closest('tr').querySelector('form.add-to-cart-form');
            if (form) form.querySelector('.quantity-field').value = this.value;
        });
    });

    document.querySelectorAll('form.add-to-cart-form').forEach(form => {
        form.addEventListener('submit', function(e) {
            const row = this.closest('tr');
            const available = parseInt(row.dataset.available || '0');
            const qtyInput = row.querySelector('.quantity-input');
            const hidden = row.querySelector('.quantity-field');
            const qty = parseInt(qtyInput ? qtyInput.value : hidden.value) || 1;
            if (qty < 1 || qty > available) {
                e.preventDefault();
                alert('Insufficient stock. Requested ' + qty + ', available ' + available + '.');
            } else {
                hidden.value = qty;
            }
        });
    });
</script>
</body>
</html>
