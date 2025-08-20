<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Add Employee - Pahana Edu</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-gray-100 font-sans">

<!-- Header -->
<header class="bg-[#4CAF50] text-white p-4 shadow-md flex justify-between items-center">
    <h1 class="text-xl font-bold">Pahana Edu - Add Employee</h1>
    <a href="${pageContext.request.contextPath}/admin/adminpanel.jsp"
       class="text-sm bg-white text-[#4CAF50] px-3 py-1 rounded-md shadow hover:bg-gray-200 transition">
        Back to Dashboard
    </a>
</header>

<!-- Form Container -->
<div class="flex justify-center items-center mt-10">
    <div class="bg-white shadow-lg rounded-xl p-8 w-full max-w-md border border-gray-300">

        <h2 class="text-2xl font-bold text-gray-800 mb-6 text-center">Employee Registration</h2>

        <!-- Registration Form -->
        <form id="staffForm" action="addstaff" method="post" class="space-y-5">

            <!-- Username -->
            <div>
                <label class="block text-gray-700 font-medium mb-1">Username</label>
                <input type="text" name="username" id="username" required
                       pattern="^[A-Za-z]{3,20}$"
                       title="Username must be 3-20 letters only."
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none
                              focus:ring-2 focus:ring-[#4CAF50]">
                <small id="usernameError" class="text-red-500 hidden">
                    Invalid username. Use 3-20 letters only.
                </small>
            </div>

            <!-- Email -->
            <div>
                <label class="block text-gray-700 font-medium mb-1">Email</label>
                <input type="email" name="email" id="email" required
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none
                              focus:ring-2 focus:ring-[#4CAF50]">
            </div>

            <!-- Password -->
            <div>
                <label class="block text-gray-700 font-medium mb-1">Password</label>
                <input type="password" name="password" id="password" required
                       pattern="^(?=.*[A-Za-z])(?=.*[0-9]).{6,}$"
                       title="Password must be at least 6 characters, include at least 1 letter and 1 number."
                       class="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none
                              focus:ring-2 focus:ring-[#4CAF50]">
                <small id="passwordError" class="text-red-500 hidden">
                    Password must be at least 6 characters, include at least 1 letter and 1 number.
                </small>
            </div>

            <!-- Hidden Field -->
            <input type="hidden" name="user_type" value="Staff">

            <!-- Submit Button -->
            <button type="submit"
                    class="w-full bg-[#4CAF50] hover:bg-[#45a049] text-white font-semibold py-2 px-4 rounded-lg shadow-md transition">
                Add Employee
            </button>
        </form>

        <!-- Success/Error Messages -->
        <div class="mt-4">
            <%
                if (request.getParameter("success") != null) {
            %>
            <p class="text-green-600 font-medium bg-green-100 border border-green-400 px-3 py-2 rounded-lg">
                Staff added successfully!
            </p>
            <%
            } else if (request.getParameter("error") != null) {
            %>
            <p class="text-red-600 font-medium bg-red-100 border border-red-400 px-3 py-2 rounded-lg">
                Email already exists. Please try again.
            </p>
            <%
                }
            %>
        </div>
    </div>
</div>

<script>
    // Client-side validation
    const form = document.getElementById("staffForm");
    const username = document.getElementById("username");
    const password = document.getElementById("password");
    const usernameError = document.getElementById("usernameError");
    const passwordError = document.getElementById("passwordError");

    form.addEventListener("submit", function(e) {
        let valid = true;

        // Username validation
        const usernamePattern = /^[A-Za-z]{3,20}$/;
        if (!usernamePattern.test(username.value)) {
            usernameError.classList.remove("hidden");
            valid = false;
        } else {
            usernameError.classList.add("hidden");
        }

        // Password validation (6+ chars, at least 1 letter & 1 number)
        const passwordPattern = /^(?=.*[A-Za-z])(?=.*[0-9]).{6,}$/;
        if (!passwordPattern.test(password.value)) {
            passwordError.classList.remove("hidden");
            valid = false;
        } else {
            passwordError.classList.add("hidden");
        }

        if (!valid) e.preventDefault();
    });
</script>

</body>
</html>
