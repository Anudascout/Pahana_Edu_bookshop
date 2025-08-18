<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Admin Panel - Pahana Edu</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-gray-100 font-sans">

<!-- Header -->
<header class="bg-[#4CAF50] text-white p-4 shadow-md flex justify-between items-center">
    <h1 class="text-xl font-bold">Pahana Edu - Admin Dashboard</h1>
    <span class="font-medium">Welcome, ${sessionScope.username}</span>
</header>

<!-- Main Section -->
<main class="p-10">
    <h2 class="text-2xl font-bold text-gray-800 mb-6">Quick Actions</h2>

    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">

        <!-- Check User -->
        <a href="${pageContext.request.contextPath}/staff/user-lookup.jsp"
           class="bg-white shadow-md rounded-xl p-6 text-center border border-gray-200 hover:shadow-lg hover:border-[#4CAF50] transition">
            <h3 class="text-lg font-semibold text-gray-800 mb-2">Check User</h3>
            <p class="text-sm text-gray-600">Search and view user details.</p>
        </a>

        <!-- Register Staff -->
        <a href="${pageContext.request.contextPath}/addEmployee.jsp"
           class="bg-white shadow-md rounded-xl p-6 text-center border border-gray-200 hover:shadow-lg hover:border-[#4CAF50] transition">
            <h3 class="text-lg font-semibold text-gray-800 mb-2">Register Staff</h3>
            <p class="text-sm text-gray-600">Add a new staff member.</p>
        </a>

        <!-- Logout -->
        <a href="${pageContext.request.contextPath}/logout.jsp"
           class="bg-white shadow-md rounded-xl p-6 text-center border border-gray-200 hover:shadow-lg hover:border-red-500 transition">
            <h3 class="text-lg font-semibold text-gray-800 mb-2">Logout</h3>
            <p class="text-sm text-gray-600">End your session securely.</p>
        </a>


        

    </div>
</main>

</body>
</html>
