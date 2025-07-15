<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Registration - BankAuto</title>
    <link rel="icon" type="image/x-icon" href="../favicon.ico">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/admin.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-gradient-primary">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-xl-8 col-lg-10 col-md-12">
                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="p-5">
                                    <div class="text-center">
                                        <i class="fas fa-user-plus fa-3x text-primary mb-4"></i>
                                        <h1 class="h4 text-gray-900 mb-4">Admin Registration</h1>
                                        <p class="text-muted">Create a new admin account for BankAuto</p>
                                    </div>
                                    
                                    <form id="adminRegisterForm" class="user">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group mb-3">
                                                    <input type="text" class="form-control form-control-user" 
                                                           name="fname" placeholder="First Name" required>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group mb-3">
                                                    <input type="text" class="form-control form-control-user" 
                                                           name="lname" placeholder="Last Name" required>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <input type="text" class="form-control form-control-user" 
                                                   name="userName" placeholder="Username" required>
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <input type="email" class="form-control form-control-user" 
                                                   name="email" placeholder="Email Address" required>
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <input type="password" class="form-control form-control-user" 
                                                   name="password" placeholder="Password (min 6 characters)" required>
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <input type="tel" class="form-control form-control-user" 
                                                   name="phoneNumber" placeholder="Phone Number" required>
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <input type="text" class="form-control form-control-user" 
                                                   name="address" placeholder="Address (Optional)">
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <input type="date" class="form-control form-control-user" 
                                                   name="dob" placeholder="Date of Birth">
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <input type="text" class="form-control form-control-user" 
                                                   name="nic" placeholder="NIC Number (Optional)">
                                        </div>
                                        
                                        <div id="loadingSpinner" class="text-center" style="display: none;">
                                            <div class="spinner-border text-primary" role="status">
                                                <span class="visually-hidden">Loading...</span>
                                            </div>
                                            <p class="mt-2">Creating admin account...</p>
                                        </div>
                                        
                                        <div id="messageContainer"></div>
                                        
                                        <button type="submit" id="registerBtn" class="btn btn-primary btn-user btn-block w-100">
                                            <i class="fas fa-user-plus"></i> Register Admin
                                        </button>
                                    </form>
                                    
                                    <hr>
                                    <div class="text-center">
                                        <a class="small" href="login.jsp">
                                            <i class="fas fa-sign-in-alt"></i> Already have an account? Login
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
