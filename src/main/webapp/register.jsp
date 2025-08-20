<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Register</title>
    <!-- Tailwind CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="flex items-center justify-center min-h-screen bg-[#F5F7FA] font-sans">

<div class="bg-white p-8 rounded-2xl shadow-xl w-[450px] border border-[#E0E0E0]">
    <h2 class="text-2xl font-bold text-center text-[#2C3E50] mb-6">User Registration</h2>

    <!-- Error Messages -->
    <%
        String error = request.getParameter("error");
        if ("empty".equals(error)) {
    %>
    <p class="text-[#E74C3C] text-center mb-4">All fields are required.</p>
    <%
    } else if ("email".equals(error)) {
    %>
    <p class="text-[#E74C3C] text-center mb-4">Email already exists.</p>
    <%
    } else if ("telephone".equals(error)) {
    %>
    <p class="text-[#E74C3C] text-center mb-4">Telephone number already exists.</p>
    <%
    } else if ("unknown".equals(error)) {
    %>
    <p class="text-[#E74C3C] text-center mb-4">An unknown error occurred.</p>
    <%
        }
    %>

    <form action="register" method="post" class="flex flex-col space-y-4">
        <input type="hidden" name="user_type" value="<%= (request.getAttribute("user_type") != null ? request.getAttribute("user_type") : "customer") %>">
        <input type="hidden" name="redirectTo" value="<%= request.getParameter("redirectTo") != null ? request.getParameter("redirectTo") : "" %>">

        <!-- Account Number -->
        <div>
            <label class="block text-sm font-semibold text-[#34495E] mb-1">Account Number</label>
            <input type="text" name="account_number"
                   value="<%= request.getAttribute("account_number") %>" readonly
                   class="w-full px-3 py-2 border border-[#BDC3C7] bg-gray-100 rounded-lg text-gray-600 cursor-not-allowed">
        </div>

        <!-- Name -->
        <div>
            <label class="block text-sm font-semibold text-[#34495E] mb-1">Name</label>
            <input type="text" name="name" required
                   class="w-full px-3 py-2 border border-[#BDC3C7] rounded-lg focus:ring-2 focus:ring-[#1ABC9C] focus:outline-none">
        </div>

        <!-- Address -->
        <div>
            <label class="block text-sm font-semibold text-[#34495E] mb-1">Address</label>
            <input type="text" name="address" required
                   class="w-full px-3 py-2 border border-[#BDC3C7] rounded-lg focus:ring-2 focus:ring-[#1ABC9C] focus:outline-none">
        </div>

        <!-- Telephone -->
        <div>
            <label class="block text-sm font-semibold text-[#34495E] mb-1">Telephone</label>
            <input type="text" name="telephone" required
                   class="w-full px-3 py-2 border border-[#BDC3C7] rounded-lg focus:ring-2 focus:ring-[#1ABC9C] focus:outline-none">
        </div>

        <!-- Email -->
        <div>
            <label class="block text-sm font-semibold text-[#34495E] mb-1">Email</label>
            <input type="email" name="email" required
                   class="w-full px-3 py-2 border border-[#BDC3C7] rounded-lg focus:ring-2 focus:ring-[#1ABC9C] focus:outline-none">
        </div>

        <!-- Submit -->
        <button type="submit"
                class="w-full bg-[#1ABC9C] hover:bg-[#16A085] text-white py-2 rounded-lg font-semibold transition">
            Register
        </button>
    </form>
</div>

</body>
</html>
