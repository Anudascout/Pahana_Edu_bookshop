<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="src.persistance.book.dao.BookDAO" %>
<%@ page import="src.business.book.model.BookModel" %>

<%
    // Handle remove from cart action
    if (request.getParameter("removeFromCart") != null) {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart != null) {
            cart.remove(bookId);
        }
    }

    // Handle update quantity action
    if (request.getParameter("updateCart") != null) {
        String[] bookIds = request.getParameterValues("bookId");
        String[] quantities = request.getParameterValues("quantity");

        if (bookIds != null && quantities != null) {
            @SuppressWarnings("unchecked")
            Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
            if (cart != null) {
                for (int i = 0; i < bookIds.length; i++) {
                    int bookId = Integer.parseInt(bookIds[i]);
                    int quantity = Integer.parseInt(quantities[i]);
                    if (quantity > 0) {
                        cart.put(bookId, quantity);
                    } else {
                        cart.remove(bookId);
                    }
                }
            }
        }
    }

    // Get cart from session
    @SuppressWarnings("unchecked")
    Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
    if (cart == null) {
        cart = new HashMap<>();
        session.setAttribute("cart", cart);
    }

    // Get book details for items in cart
    BookDAO bookDAO = new BookDAO();
    Map<Integer, BookModel> bookDetails = new HashMap<>();
    double total = 0.0;

    for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
        int bookId = entry.getKey();
        int quantity = entry.getValue();
        BookModel book = bookDAO.getBookById(bookId);
        if (book != null) {
            bookDetails.put(bookId, book);
            total += book.getPrice() * quantity;
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>View Cart</title>
    <!-- Tailwind CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[#F5F7FA] font-sans">

<div class="max-w-5xl mx-auto mt-10 bg-white shadow-lg rounded-2xl p-8">
    <h1 class="text-2xl font-bold text-[#2C3E50] mb-6">Your Shopping Cart</h1>

    <% if (cart.isEmpty()) { %>
    <!-- Empty Cart -->
    <div class="text-center py-16 text-gray-600">
        <h2 class="text-xl font-semibold mb-2">Your cart is empty</h2>
        <p class="mb-6">Looks like you haven't added any items yet.</p>
        <a href="select_books.jsp"
           class="inline-block px-6 py-2 bg-gray-600 text-white rounded-lg hover:bg-gray-700 transition">
            Continue Shopping
        </a>
    </div>
    <% } else { %>

    <form method="post" action="view_cart.jsp">
        <!-- Cart Table -->
        <div class="overflow-x-auto">
            <table class="w-full border border-gray-200 rounded-lg overflow-hidden">
                <thead class="bg-[#1ABC9C] text-white">
                <tr>
                    <th class="px-4 py-3 text-left">Title</th>
                    <th class="px-4 py-3 text-left">Price</th>
                    <th class="px-4 py-3 text-left">Quantity</th>
                    <th class="px-4 py-3 text-left">Total</th>
                    <th class="px-4 py-3 text-left">Action</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-gray-200">
                <% for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                    int bookId = entry.getKey();
                    int quantity = entry.getValue();
                    BookModel book = bookDetails.get(bookId);
                    if (book != null) {
                        double itemTotal = book.getPrice() * quantity;
                %>
                <tr class="hover:bg-gray-50">
                    <td class="px-4 py-3"><%= book.getName() %></td>
                    <td class="px-4 py-3">Rs. <%= String.format("%.2f", book.getPrice()) %></td>
                    <td class="px-4 py-3">
                        <input type="hidden" name="bookId" value="<%= bookId %>">
                        <input type="number" name="quantity"
                               class="w-20 px-2 py-1 border border-gray-300 rounded-lg text-center"
                               min="1" max="<%= book.getQty() %>"
                               value="<%= quantity %>">
                    </td>
                    <td class="px-4 py-3 font-medium">Rs. <%= String.format("%.2f", itemTotal) %></td>
                    <td class="px-4 py-3">
                        <button type="submit"
                                name="removeFromCart"
                                value="<%= bookId %>"
                                class="px-3 py-1 bg-[#E74C3C] text-white rounded-lg text-sm hover:bg-red-700 transition">
                            Remove
                        </button>
                    </td>
                </tr>
                <% }} %>
                </tbody>
            </table>
        </div>

        <!-- Summary Section -->
        <div class="flex flex-col md:flex-row justify-between items-center mt-6 gap-4">
            <a href="select_books.jsp"
               class="px-6 py-2 bg-gray-600 text-white rounded-lg hover:bg-gray-700 transition">
                Continue Shopping
            </a>

            <div class="flex items-center space-x-4">
                <span class="text-lg font-bold text-[#2C3E50]">
                    Total: Rs. <%= String.format("%.2f", total) %>
                </span>
                <button type="submit" name="updateCart"
                        class="px-6 py-2 bg-[#1ABC9C] text-white rounded-lg hover:bg-[#16A085] transition">
                    Update Cart
                </button>
                <a href="<%= request.getContextPath() %>/checkout"
                   class="px-6 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition">
                    Proceed to Checkout
                </a>
            </div>
        </div>
    </form>
    <% } %>
</div>

</body>
</html>
