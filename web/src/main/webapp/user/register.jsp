<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration - BankAuto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="../css/user.css" rel="stylesheet">
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
                                        <h1 class="h4 text-gray-900 mb-4">Create Your BankAuto User Account</h1>
                                        <p class="text-muted">Join thousands of satisfied customers. Create bank accounts after registration.</p>
                                    </div>
                                    
                                    <form class="user" id="registrationForm">
                                        <div class="row">
                                            <div class="col-sm-6 mb-3">
                                                <input type="text" class="form-control form-control-user" 
                                                       id="firstName" name="firstName" placeholder="First Name" required>
                                            </div>
                                            <div class="col-sm-6 mb-3">
                                                <input type="text" class="form-control form-control-user" 
                                                       id="lastName" name="lastName" placeholder="Last Name" required>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <input type="text" class="form-control form-control-user" 
                                                   id="username" name="username" placeholder="Username" required>
                                            <small class="form-text text-muted">Choose a unique username for your account</small>
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <input type="email" class="form-control form-control-user" 
                                                   id="email" name="email" placeholder="Email Address" required>
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <input type="tel" class="form-control form-control-user" 
                                                   id="phone" name="phone" placeholder="Mobile Number (e.g., 0771234567)" required>
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <input type="date" class="form-control form-control-user" 
                                                   id="dateOfBirth" name="dateOfBirth" required>
                                            <small class="form-text text-muted">Date of Birth</small>
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <textarea class="form-control" id="address" name="address" 
                                                      rows="3" placeholder="Full Address" required></textarea>
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <input type="text" class="form-control form-control-user" 
                                                   id="idNumber" name="idNumber" placeholder="NIC Number" required>
                                        </div>
                                        
                                        <div class="row">
                                            <div class="col-sm-6 mb-3">
                                                <input type="password" class="form-control form-control-user" 
                                                       id="password" name="password" placeholder="Password" required>
                                            </div>
                                            <div class="col-sm-6 mb-3">
                                                <input type="password" class="form-control form-control-user" 
                                                       id="confirmPassword" name="confirmPassword" 
                                                       placeholder="Confirm Password" required>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" class="custom-control-input" id="agreeTerms" required>
                                                <label class="custom-control-label" for="agreeTerms">
                                                    I agree to the <a href="#" class="text-primary">Terms of Service</a> 
                                                    and <a href="#" class="text-primary">Privacy Policy</a>
                                                </label>
                                            </div>
                                        </div>
                                        
                                        <div class="form-group mb-3">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" class="custom-control-input" id="newsletter">
                                                <label class="custom-control-label" for="newsletter">
                                                    Subscribe to newsletter for updates and offers
                                                </label>
                                            </div>
                                        </div>
                                        
                                        <button type="submit" class="btn btn-primary btn-user btn-block w-100">
                                            <i class="fas fa-user-plus"></i> Create User Account
                                        </button>
                                    </form>
                                    
                                    <hr>
                                    <div class="text-center">
                                        <div class="alert alert-info">
                                            <i class="fas fa-info-circle"></i>
                                            <strong>Next Step:</strong> After registration, you can create your bank accounts from your dashboard.
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <a class="small" href="login.jsp">Already have an account? Login!</a>
                                    </div>
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
    <script src="../js/register.js"></script>
</body>
</html>
