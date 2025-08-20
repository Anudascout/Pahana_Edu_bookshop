<%--
  Created by IntelliJ IDEA.
  User: Dileeka
  Date: 8/5/2025
  Time: 11:39 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ page import="java.util.Enumeration" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Staff Panel - Pahana Edu</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-[#F5F7FA] font-sans">

<!-- Header -->
<header class="bg-[#1ABC9C] text-white p-4 shadow-md flex justify-between items-center">
    <h1 class="text-xl font-bold">Pahana Edu - Staff Dashboard</h1>
    <span class="font-medium">Welcome, ${sessionScope.username}</span>
</header>

<!-- Main Content -->
<div class="flex">

    <!-- Sidebar Navigation -->
    <aside class="w-64 bg-white shadow-lg min-h-screen p-6 border-r border-[#E0E0E0]">
        <h2 class="text-lg font-semibold text-[#2C3E50] mb-4">Navigation</h2>
        <ul class="space-y-3">
            <li>
                <a href="${pageContext.request.contextPath}/manage-books"
                   class="block px-3 py-2 rounded-lg hover:bg-[#1ABC9C] hover:text-white transition">Manage Books</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/manage-users"
                   class="block px-3 py-2 rounded-lg hover:bg-[#1ABC9C] hover:text-white transition">Manage Users</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/manage-categories"
                   class="block px-3 py-2 rounded-lg hover:bg-[#1ABC9C] hover:text-white transition">Manage Categories</a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/check-user-bill"
                   class="block px-3 py-2 rounded-lg hover:bg-[#1ABC9C] hover:text-white transition">Billing</a>
            </li>
        </ul>
    </aside>

    <!-- Main Section -->
    <main class="flex-1 p-8">
        <h2 class="text-xl font-bold text-[#2C3E50] mb-6">Quick Actions</h2>

        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <!-- Card 1 -->
            <a href="${pageContext.request.contextPath}/staff/user-lookup.jsp"
               class="bg-white shadow-md rounded-xl p-6 text-center border border-[#E0E0E0] hover:shadow-lg hover:border-[#1ABC9C] transition">
                <h3 class="text-lg font-semibold text-[#34495E] mb-2">Check User</h3>
                <p class="text-sm text-gray-600">Search for user details quickly.</p>
            </a>

            <!-- Card 2 -->
            <a href="${pageContext.request.contextPath}/register?user_type=customer&redirectTo=${pageContext.request.contextPath}/staff/user-lookup.jsp"
               class="bg-white shadow-md rounded-xl p-6 text-center border border-[#E0E0E0] hover:shadow-lg hover:border-[#1ABC9C] transition">
                <h3 class="text-lg font-semibold text-[#34495E] mb-2">Register User</h3>
                <p class="text-sm text-gray-600">Add a new user account.</p>
            </a>

            <!-- Card 3 -->
            <a href="${pageContext.request.contextPath}/logout.jsp"
               class="bg-white shadow-md rounded-xl p-6 text-center border border-[#E0E0E0] hover:shadow-lg hover:border-[#E74C3C] transition">
                <h3 class="text-lg font-semibold text-[#34495E] mb-2">Logout</h3>
                <p class="text-sm text-gray-600">End your session securely.</p>
            </a>
        </div>
    </main>
</div>

</body>
</html>
