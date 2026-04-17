
<!DOCTYPE html>
<%@page import="java.time.LocalDate"%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
     <style>
        
       * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    html, body {
      height: 100%;
    }
    body {
      display: flex;
      flex-direction: column;
      justify-content: space-between;
    }
    .content {
      flex: 1;
    } 
    footer {
    font-size:14px;
          background-color: #1582AB;
      color: #fff;
      text-align: center;
      padding: 2px;
     position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    z-index:1000;
    } 
    </style>
</head>
<body>
<%
LocalDate CDate = LocalDate.now();
%>
    <div class="content">
    </div>

    <footer class="footer">
        Copyright &copy; 2008-<%=CDate.getYear()%> by Transworld Technologies Ltd. All Rights Reserved.
    </footer>
</body>
</html>
