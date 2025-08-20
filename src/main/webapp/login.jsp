<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login</title>
    <!-- Tailwind CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        function validateLoginForm() {
            const email = document.forms["loginForm"]["email"].value.trim();
            const password = document.forms["loginForm"]["password"].value.trim();
            let errors = [];

            // Email validation
            const emailPattern = /^[^ ]+@[^ ]+\.[a-z]{2,}$/;
            if (!email.match(emailPattern)) {
                errors.push("Please enter a valid email address.");
            }

            // Password validation
            if (password.length < 6) {
                errors.push("Password must be at least 6 characters long.");
            }

            // Show error messages
            const errorBox = document.getElementById("errorMessages");
            if (errors.length > 0) {
                errorBox.innerHTML = errors.join("<br>");
                errorBox.classList.remove("hidden");
                return false; // stop form submission
            } else {
                errorBox.classList.add("hidden");
                return true; // allow form submit
            }
        }
    </script>
</head>
<body class="flex items-center justify-center min-h-screen bg-[#F5F7FA] font-sans">

<div class="bg-white p-8 rounded-2xl shadow-xl w-96 border border-[#E0E0E0]">
    <h2 class="text-2xl font-bold text-center text-[#2C3E50] mb-6">Login</h2>

    <!-- Error Messages -->
    <div id="errorMessages" class="hidden mb-4 text-[#E74C3C] font-medium text-sm text-center"></div>

    <form name="loginForm" method="post" action="login"
          class="flex flex-col space-y-4" onsubmit="return validateLoginForm()">

        <div>
            <label class="block text-sm font-semibold text-[#34495E] mb-1">Email</label>
            <input type="text" name="email" required
                   class="w-full px-3 py-2 border border-[#BDC3C7] rounded-lg focus:ring-2 focus:ring-[#1ABC9C] focus:outline-none">
        </div>

        <div>
            <label class="block text-sm font-semibold text-[#34495E] mb-1">Password</label>
            <input type="password" name="password" required
                   class="w-full px-3 py-2 border border-[#BDC3C7] rounded-lg focus:ring-2 focus:ring-[#1ABC9C] focus:outline-none">
        </div>

        <button type="submit"
                class="w-full bg-[#1ABC9C] hover:bg-[#16A085] text-white py-2 rounded-lg font-semibold transition">
            Login
        </button>
    </form>

    <%
        if (request.getParameter("error") != null) {
    %>
    <p class="text-[#E74C3C] text-center mt-4">Invalid credentials. Please try again.</p>
    <%
        }
    %>
</div>

</body>
</html>
