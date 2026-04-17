<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>SmartSuite</title>
    <link rel="icon" type="imagenew/x-icon" href="imagesnew/SSFavicon.png">

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Bootstrap Icons CDN -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

  <!-- Custom CSS -->
  <style>
    html, body {
      margin: 0;
      padding: 0;
      overflow-x: hidden;
      height: 100%;
      font-family: 'Poppins', sans-serif;
    }

/* Navbar */
.navbar {
  padding: 1rem 2rem;
  background: transparent !important;  /* Transparent over image */
  position: absolute;                  /* Place inside hero */
  top: 0;
  left: 0;
  width: 100%;
  z-index: 3;                          /* Above hero overlay */
}

.navbar .nav-link,
.navbar .navbar-brand,
.navbar .btn {
  color: #fff !important;              /* White text */
}

.navbar .btn-outline-dark {
 background-color: #ff4da6;  
  
  color: #fff !important;
}

.navbar .btn-outline-dark:hover {
  background-color: #020202;
 
  color: #fff !important;
}


    /* Hover Effects */
    .hero h1:hover,
    .hero p:hover,
    .nav-link:hover,
    .navbar-brand:hover {
      color: #ff4da6 !important;
      transition: color 0.3s ease-in-out;
    }

    .btn-dark:hover {
      background-color: #fa0000;
      border-color: #ff4da6;
      transition: all 0.3s ease-in-out;
    }

    /* Hero Section */
    .hero {
      position: relative;
      height: 100vh;
      background: url("imagesnew/SS.jpg") no-repeat center center/cover;
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
      color: white;
      overflow: hidden;
      animation: zoomBg 8s ease-in-out alternate forwards;
    }
    
    @keyframes zoomBg {
      from { transform: scale(1); }
      to { transform: scale(1); }
    }
    .hero::before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0,0,0,0.5);
      z-index: 1;
    }
   
   .hero-content {
  position: relative;
  z-index: 2;
  max-width: 700px;
  padding: 20px;
  animation: moveSequence 6s ease-in-out infinite;
}

@keyframes moveSequence {
  0% {
    opacity: 0;
    transform: translateY(30px); /* fade in from bottom */
  }
  20% {
    opacity: 1;
    transform: translateY(0); /* in position */
  }
  40% {
    transform: translateY(-30px); /* move up */
  }
  60% {
    transform: translateY(30px); /* move down */
  }
  80% {
    transform: translateX(30px); /* move right */
  }
  100% {
    transform: translateX(0); /* back to center */
  }
}
   
   
    .hero h1 {
      font-size: 3.5rem;
      font-weight: 700;
      margin-bottom: 20px;
    }
    .hero p {
      font-size: 1.3rem;
      margin-bottom: 25px;
    }
    .hero .btn-dark {
      padding: 12px 28px;
      border-radius: 30px;
      font-size: 1rem;
    }
    

    /* Login Modal Customization */
    .modal-backdrop.show {
      backdrop-filter: blur(5px);
      background-color: rgba(0,0,0,0.4);
    }
    .modal-content {
      border-radius: 15px;
      border: none;
      background: rgba(255,255,255,0.8);
      backdrop-filter: blur(10px);
      animation: fadeInUp 0.5s ease-in-out;
      box-shadow: 0 10px 30px rgba(0,0,0,0.3);
    }
    @keyframes fadeInUp {
      from { transform: translateY(40px); opacity: 0; }
      to { transform: translateY(0); opacity: 1; }
    }
    
    
    .modal-header {
      border-bottom: none;
      text-align: center;
      display: block;
    }
    .modal-title {
      font-weight: 600;
      font-size: 1.5rem;
      color: #333;
    }
    .form-control {
      border-radius: 10px;
    }
    .btn-login {
      background: #379cbf;
      border: none;
      border-radius: 30px;
      padding: 10px 20px;
      font-weight: 600;
      color: #fff;
      transition: 0.3s;
    }
    .btn-login:hover {
      background: #2e8aac;
    }
    
        .login-icon {
      width: 80px;
      height: 80px;
      background: #379cbf;
      border-radius: 50%;
      display: flex;
      justify-content: center;
      align-items: center;
      margin: 0 auto 20px auto;
    }

    .login-icon i {
      color: white;
      font-size: 28px;
    }
    
   .navbar .nav-link {
  font-size: 1.1rem;   /* increase text size */
 
}
.navbar-brand {
  font-family: 'Poppins', sans-serif;
  font-size: 1.8rem;
  font-weight: 600;
  color: #fff !important;  /* stays visible on hero image */
}

.navbar-brand {
  animation: bounceIn 1.5s ease-in-out 5;
}

@keyframes bounceIn {
  0%   { transform: scale(0.9); opacity: 0.8; }
  50%  { transform: scale(1.2); opacity: 1; }
  100% { transform: scale(1); opacity: 0.9; }
}

.input-group-text {
font-size: 1.2rem;

}
    
  </style>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

</head>
<body>

  <!-- Navbar -->
  <nav class="navbar navbar-expand-lg fixed-top shadow-sm">
    <div class="container">
      <a class="" href="http://twtech.in/SmartSuiteTest/"><img src="imagesnew/SSlogo.png" width="200" height="60"/></a>
      
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
        <ul class="navbar-nav">
          <li class="nav-item"><a class="nav-link" href="http://twtech.in/SmartSuite/"><b>Home</b></a></li>
          <li class="nav-item"><a class="nav-link" href="#"><b>Blogs</b></a></li>
          <li class="nav-item"><a class="nav-link" href="#"><b>About</b></a></li>
          <li class="nav-item"><a class="nav-link" href="#"><b>Contact</b></a></li>
        </ul>
        <!-- Trigger Login Modal -->
        <button class="btn btn-outline-dark ms-3"  data-bs-toggle="modal" data-bs-target="#loginModal">
          <i class="bi bi-box-arrow-in-right"></i> Login
        </button>
      </div>
    </div>
  </nav>

  <!-- Hero Section -->
  <section class="hero">
    <div class="hero-content">
      <h1>SmartSuite</h1>
      <p>Transworld Technologies LTD.</p>
     <!--  <a href="#" class="btn btn-dark">Started</a> -->
    </div>
  </section>

 <!-- Login Modal -->
<div class="modal fade" id="loginModal" tabindex="-1">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content p-4">
    <!-- <div align="right"><button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button></div> -->
      <div class="login-icon" style="margin-top: -50px">
        <i class="bi bi-person-fill"></i>
        
      </div>
      
        
      <div class="modal-header">
        <h5 class="modal-title">Login to SmartSuite</h5>
      
      </div>
      
      <div class="modal-body">
       <form name="erplogin" action="login.jsp" method="post" onsubmit="return validate();">
        				<%
                        try {
                            String msg = request.getParameter("err");
                            if ("err1".equals(msg)) {
                                out.print("<font color='blue' size='2'>Please Enter Correct UserName and Password</font>");
                            } else if ("err2".equals(msg)) {
                                out.print("<font color='blue' size='2'><blink>Session Expired, Please login again.</blink></font>");
                            } else if ("serverDown".equals(msg)) {
                                out.print("<font color='blue' size='2'><blink>SERVER is down right now.<br> Please try after some time.</blink></font>");
                            } 
                        } catch (Exception a) {}
                    %>	
          <div class="mb-3 input-group">
            <span class="input-group-text bg-white"><i class="bi bi-person-fill"></i></span>
            <input type="text" class="form-control" placeholder="Username" id="username" name="username"  required>
          </div>
          
          <div class="mb-3 input-group">
            <span class="input-group-text bg-white"><i class="bi bi-lock-fill"></i></span>
            <input type="password" class="form-control" placeholder="Password" id="pass" name="pass"  required>
          </div>
          
          <div class="d-flex justify-content-between align-items-center mb-3"></div>
          
          <div class="d-flex justify-content-center">
            <button type="submit" class="btn btn-login w-50">Login</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<script>
        function validate() {
            if (document.getElementById("username").value == "") {
                alert("Please Enter User Name");
                return false;
            }
            if (document.getElementById("pass").value == "") {
                alert("Please Enter password");
                return false;
            }
            return true;
        }
 </script>
  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>