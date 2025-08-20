<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Lookup - Pahana Edu</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">

<div class="w-full max-w-md">
    <div class="bg-white shadow-lg rounded-xl overflow-hidden">
        <!-- Header -->
        <div class="bg-emerald-500 px-6 py-4">
            <h4 class="text-white text-lg font-semibold">User Check</h4>
        </div>

        <!-- Body -->
        <div class="p-6">
            <%-- Error Message --%>
            <% if (request.getAttribute("error") != null) { %>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                <p><%= request.getAttribute("error") %></p>
                <a href="<%= request.getContextPath() %>/register?user_type=customer&redirectTo=<%= request.getContextPath() %>/staff/user-lookup.jsp"
                   class="text-emerald-600 font-medium underline">Register as new user</a>
            </div>
            <% } %>

            <!-- Form -->
            <form action="<%= request.getContextPath() %>/check-user-bill" method="GET" class="space-y-4">
                <div>
                    <label for="searchTerm" class="block text-gray-700 font-medium mb-1">Enter Email or Phone Number</label>
                    <input type="text"
                           id="searchTerm"
                           name="searchTerm"
                           value="<%= request.getParameter("searchTerm") != null ? request.getParameter("searchTerm") : "" %>"
                           required
                           class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-emerald-500 focus:outline-none">
                </div>

                <div class="flex flex-col gap-3">
                    <button type="submit"
                            class="w-full bg-emerald-500 text-white py-2 rounded-lg hover:bg-emerald-600 transition">
                        Search User
                    </button>
                    <a href="<%= request.getContextPath() %>/staff"
                       class="w-full bg-gray-500 text-white py-2 rounded-lg text-center hover:bg-gray-600 transition">
                        Back to Dashboard
                    </a>
                </div>
            </form>

            <!-- Register -->
            <div class="mt-4 text-center text-sm text-gray-600">
                <p>
                    New user?
                    <a href="<%= request.getContextPath() %>/register?user_type=customer&redirectTo=<%= request.getContextPath() %>/staff/user-lookup.jsp"
                       class="text-emerald-600 hover:underline">Register here</a>
                </p>
            </div>
        </div>
    </div>
</div>

</body>
</html>
