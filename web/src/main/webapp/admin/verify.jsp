<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Email Verification - BankAuto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/admin.css" rel="stylesheet">
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
                                <div class="p-5">
                                    <div class="text-center">
                                        <i class="fas fa-envelope-open fa-3x text-primary mb-4"></i>
                                        <h1 class="h4 text-gray-900 mb-4">Email Verification</h1>
                                        <p class="text-muted">Please enter the verification code sent to your email</p>
                                        <div class="alert alert-info" role="alert">
                                            <i class="fas fa-info-circle"></i> Check your email inbox for the verification code. It expires in 24 hours.
                                        </div>
                                    </div>
                                    
                                    <form id="verifyForm" class="user">
                                        <input type="hidden" id="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                                        
                                        <div class="form-group mb-3">
                                            <input type="text" class="form-control form-control-user" 
                                                   id="verificationCode" placeholder="Enter Verification Code" required>
                                        </div>
                                        
                                        <div id="loadingSpinner" class="text-center" style="display: none;">
                                            <div class="spinner-border text-primary" role="status">
                                                <span class="visually-hidden">Verifying...</span>
                                            </div>
                                            <p class="mt-2">Verifying your email...</p>
                                        </div>
                                        
                                        <div id="messageContainer"></div>
                                        
                                        <button type="submit" id="verifyBtn" class="btn btn-primary btn-user btn-block w-100">
                                            <i class="fas fa-check"></i> Verify Email
                                        </button>
                                    </form>
                                    
                                    <hr>
                                    <div class="text-center">
                                        <a class="small" href="register.jsp">
                                            <i class="fas fa-arrow-left"></i> Back to Registration
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
    <script src="../js/api-client.js"></script>
    <script src="../js/form-utils.js"></script>
    <script src="../js/admin-auth.js"></script>
</body>
</html>
