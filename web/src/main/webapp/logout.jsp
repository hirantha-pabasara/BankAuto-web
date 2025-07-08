<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidate the session
    session.invalidate();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logged Out - BankAuto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-primary">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-xl-6 col-lg-8 col-md-10">
                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="p-5 text-center">
                                    <i class="fas fa-sign-out-alt fa-3x text-success mb-4"></i>
                                    <h1 class="h4 text-gray-900 mb-4">Successfully Logged Out</h1>
                                    <p class="text-muted mb-4">Thank you for using BankAuto. You have been safely logged out of your account.</p>
                                    
                                    <div class="alert alert-info" role="alert">
                                        <i class="fas fa-info-circle"></i>
                                        <strong>Security Tip:</strong> Always log out when using public computers or shared devices.
                                    </div>
                                    
                                    <div class="d-grid gap-3 mt-4">
                                        <a href="index.jsp" class="btn btn-primary btn-lg">
                                            <i class="fas fa-home me-2"></i>Return to Home
                                        </a>
                                        <a href="user/login.jsp" class="btn btn-outline-primary btn-lg">
                                            <i class="fas fa-sign-in-alt me-2"></i>Login Again
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Clear any stored session data
        if (typeof(Storage) !== "undefined") {
            localStorage.clear();
            sessionStorage.clear();
        }
        
        // Redirect to home page after 5 seconds
        setTimeout(function() {
            window.location.href = 'index.jsp';
        }, 5000);
    </script>
</body>
</html>
