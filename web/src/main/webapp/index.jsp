<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BankAuto - Welcome</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .bg-gradient-primary {
            background: linear-gradient(135deg, #007bff, #0056b3);
        }
        
        .card {
            font-size: 1.5rem;
            font-weight: bold;
            margin-bottom: 20px;
        }
        
        .hero-section p {
            font-size: 1.3rem;
            margin-bottom: 40px;
        }
        
        .btn-hero {
            padding: 15px 40px;
            font-size: 1.1rem;
            margin: 0 10px;
            margin-bottom: 10px;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-section h1 {
                font-size: 2.5rem;
            }
            
            .hero-section p {
                font-size: 1.1rem;
            }
            
            .btn-hero {
                padding: 12px 30px;
                font-size: 1rem;
                margin: 5px;
                display: block;
                width: 100%;
                max-width: 300px;
                margin-left: auto;
                margin-right: auto;
            }
            
            .hero-buttons {
                text-align: center;
            }
        }
        
        @media (max-width: 576px) {
            .hero-section {
                padding: 60px 0;
            }
            
            .hero-section h1 {
                font-size: 2rem;
            }
            
            .login-section {
                padding: 60px 0;
            }
            
            .display-4 {
                font-size: 2rem;
            }
        }
        
        .feature-card {
            transition: transform 0.3s ease;
            height: 100%;
        }
        
        .feature-card:hover {
            transform: translateY(-5px);
        }
        
        .feature-icon {
            font-size: 3rem;
            margin-bottom: 20px;
            color: #007bff;
        }
        
        .login-section {
            padding: 80px 0;
            background-color: #f8f9fa;
        }
        
        .footer {
            background-color: #343a40;
            color: white;
            padding: 40px 0;
            text-align: center;
        }
        
        .navbar-brand {
            font-size: 1.8rem;
            font-weight: bold;
        }
        
        /* Responsive navbar */
        @media (max-width: 768px) {
            .navbar-brand {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">
                <i class="fas fa-university"></i> BankAuto
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#features">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#login">Login</a>
                    </li>
                    <li class="nav-item">
                        <!-- TODO: Connect to backend registration system -->
                        <a class="nav-link" href="user/register.jsp">Register</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <h1>Welcome to BankAuto</h1>
                    <p class="lead">Your trusted partner for secure and convenient banking solutions. Experience the future of banking with our automated services.</p>
                    <div class="hero-buttons">
                        <!-- TODO: Connect to backend registration system -->
                        <a href="user/register.jsp" class="btn btn-success btn-hero">
                            <i class="fas fa-user-plus"></i> Create User Account
                        </a>
                        <a href="#features" class="btn btn-outline-light btn-hero">
                            <i class="fas fa-info-circle"></i> Learn More
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center mb-5">
                    <h2 class="display-4">Why Choose BankAuto?</h2>
                    <p class="lead">Discover the benefits of automated banking with our comprehensive suite of services</p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <div class="feature-icon">
                                <i class="fas fa-shield-alt"></i>
                            </div>
                            <h5 class="card-title">Secure Banking</h5>
                            <p class="card-text">Your financial security is our top priority. We use advanced encryption and security measures to protect your data.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <div class="feature-icon">
                                <i class="fas fa-mobile-alt"></i>
                            </div>
                            <h5 class="card-title">24/7 Access</h5>
                            <p class="card-text">Access your accounts anytime, anywhere. Our platform is available round the clock for your convenience.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <div class="feature-icon">
                                <i class="fas fa-robot"></i>
                            </div>
                            <h5 class="card-title">Automated Services</h5>
                            <p class="card-text">Experience the power of automation with intelligent banking solutions that work for you.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Login Section -->
    <section id="login" class="login-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center mb-5">
                    <h2 class="display-4">Access Your Account</h2>
                    <p class="lead">Choose your login portal to access your banking dashboard</p>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-5 col-lg-4 mb-4">
                    <div class="card shadow-lg">
                        <div class="card-body text-center p-4 p-md-5">
                            <div class="mb-4">
                                <i class="fas fa-user fa-3x text-success"></i>
                            </div>
                            <h4 class="card-title">User Login</h4>
                            <p class="card-text">Access your personal banking dashboard, view accounts, and manage transactions.</p>
                            <!-- TODO: Connect to backend authentication system -->
                            <a href="user/login.jsp" class="btn btn-success btn-lg w-100">
                                <i class="fas fa-sign-in-alt"></i> User Login
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-5 col-lg-4 mb-4">
                    <div class="card shadow-lg">
                        <div class="card-body text-center p-4 p-md-5">
                            <div class="mb-4">
                                <i class="fas fa-user-shield fa-3x text-primary"></i>
                            </div>
                            <h4 class="card-title">Admin Login</h4>
                            <p class="card-text">Administrative access for managing users, accounts, and system operations.</p>
                            <!-- TODO: Connect to backend admin authentication system -->
                            <a href="admin/login.jsp" class="btn btn-primary btn-lg w-100">
                                <i class="fas fa-shield-alt"></i> Admin Login
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center mb-5">
                    <h2 class="display-4">Our Services</h2>
                    <p class="lead">Comprehensive banking solutions tailored to your needs</p>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3 col-sm-6 mb-4">
                    <div class="text-center">
                        <i class="fas fa-credit-card fa-3x text-primary mb-3"></i>
                        <h5>Account Management</h5>
                        <p>Create and manage multiple accounts with ease</p>
                        <!-- TODO: Implement account management backend -->
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-4">
                    <div class="text-center">
                        <i class="fas fa-exchange-alt fa-3x text-success mb-3"></i>
                        <h5>Instant Transfers</h5>
                        <p>Transfer money between accounts instantly</p>
                        <!-- TODO: Implement transfer system backend -->
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-4">
                    <div class="text-center">
                        <i class="fas fa-bell fa-3x text-warning mb-3"></i>
                        <h5>Notifications</h5>
                        <p>Stay updated with real-time transaction alerts</p>
                        <!-- TODO: Implement notification system backend -->
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 mb-4">
                    <div class="text-center">
                        <i class="fas fa-chart-line fa-3x text-info mb-3"></i>
                        <h5>Analytics</h5>
                        <p>Track your spending and financial growth</p>
                        <!-- TODO: Implement analytics backend -->
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <p>&copy; 2025 BankAuto. All rights reserved.</p>
                    <p class="mb-0">
                        <i class="fas fa-university"></i> Your trusted banking partner since 2025
                    </p>
                </div>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="js/main.js"></script>
    
    <!-- TODO: Backend Integration Notes -->
    <!--
        All backend requests are currently disabled and will be enabled after backend implementation:
        - User registration system
        - User authentication system  
        - Admin authentication system
        - Account management backend
        - Transfer system backend
        - Notification system backend
        - Analytics backend
        
        Current state: Frontend UI completed
        Next steps: Implement backend servlets and database connections
    -->
</body>
</html>
