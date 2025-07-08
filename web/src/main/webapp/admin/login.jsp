<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login - BankAuto</title>
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
                                        <i class="fas fa-user-shield fa-3x text-primary mb-4"></i>
                                        <h1 class="h4 text-gray-900 mb-4">Admin Login</h1>
                                        <p class="text-muted">Please enter your credentials to access the admin dashboard</p>
                                    </div>
                                    
                                    <form class="user" method="post" action="">
                                        <div class="form-group mb-3">
                                            <input type="text" class="form-control form-control-user" 
                                                   id="adminId" name="adminId" placeholder="Admin ID" required>
                                        </div>
                                        <div class="form-group mb-3">
                                            <input type="password" class="form-control form-control-user" 
                                                   id="password" name="password" placeholder="Password" required>
                                        </div>
                                        <div class="form-group mb-3">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" class="custom-control-input" id="rememberMe">
                                                <label class="custom-control-label" for="rememberMe">Remember Me</label>
                                            </div>
                                        </div>
                                        <button type="submit" class="btn btn-primary btn-user btn-block w-100">
                                            <i class="fas fa-sign-in-alt"></i> Login
                                        </button>
                                    </form>
                                    
                                    <hr>
                                    <div class="text-center">
                                        <a class="small" href="../index.jsp">
                                            <i class="fas fa-arrow-left"></i> Back to Home
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
    <script src="../js/validation.js"></script>
</body>
</html>
