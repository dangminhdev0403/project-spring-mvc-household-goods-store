<%@page contentType="text/html" pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="form"
uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Grocery Mart</title>

    <!-- Favicon -->
    <link
      rel="apple-touch-icon"
      sizes="76x76"
      href="/client/assets/favicon/apple-touch-icon.png"
    />
    <link
      rel="icon"
      type="image/png"
      sizes="32x32"
      href="/client/assets/favicon/favicon-32x32.png"
    />
    <link
      rel="icon"
      type="image/png"
      sizes="16x16"
      href="/client/assets/favicon/favicon-16x16.png"
    />
    <link rel="manifest" href="/client/assets/favicon/site.webmanifest" />
    <meta name="msapplication-TileColor" content="#da532c" />
    <meta name="theme-color" content="#ffffff" />

    <!-- Fonts -->
    <link rel="stylesheet" href="/client/assets/fonts/stylesheet.css" />

    <!-- Styles -->
    <link rel="stylesheet" href="/client/assets/css/main.css" />

    <!-- Scripts -->
    <script src="/client/assets/js/scripts.js"></script>
  
  </head>
  <body>
    <header id="header" class="header"></header>
    <script>
      load("#header", "/api/header-logined");
    </script>
  </body>
</html>
