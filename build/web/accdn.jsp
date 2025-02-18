<!DOCTYPE html>
<html>
<head>
    <title>Access Denied</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"/>
    <style>
        body {
            background-color: #ffeb3b; /* Bright yellow background */
            color: black; /* Text color */
            font-family: Arial, sans-serif;
            text-align: center; /* Center align text */
        }

        h1 {
            color: red;
        }

        h6 {
            color: red;
            text-decoration: underline;
        }

        .icon {
            font-size: 50px; /* Size of the icon */
            color: red; /* Color of the icon */
        }

        .button {
            background-color: red; /* Button color */
            color: white; /* Button text color */
            padding: 15px 30px; /* Button padding */
            border: none; /* Remove border */
            border-radius: 25px; /* Rounded corners */
            font-size: 18px; /* Font size */
            cursor: pointer; /* Pointer cursor on hover */
            margin-top: 20px; /* Space above button */
            transition: background-color 0.3s, transform 0.3s; /* Smooth transition */
        }

        .button:hover {
            background-color: darkred; /* Darker shade on hover */
            transform: scale(1.05); /* Slightly enlarge button */
        }

        .button:focus {
            outline: none; /* Remove outline on focus */
        }
    </style>
</head>
<body>
    <div class="w3-display-middle">
        <h1 class="w3-jumbo w3-animate-top"><code>Access Denied</code></h1>
        <hr class="w3-border-black w3-animate-left" style="margin:auto;width:50%">
        <h3 class="w3-animate-right">You don't have permission to view this site.</h3>
        <h3 class="w3-animate-zoom"><i class="fas fa-ban icon"></i></h3> <!-- Access denied icon -->
        <h6 class="w3-animate-zoom">error code: 403 forbidden</h6>
        <button class="button" onclick="window.location.href='home.jsp'">Back to Home</button> <!-- Back to Home button -->
    </div>
</body>
</html>