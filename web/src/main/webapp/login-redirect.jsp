<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Required - BankAuto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="css/main.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid vh-100 d-flex align-items-center justify-content-center">
        <div class="row">
            <div class="col-12 col-md-6 col-lg-4">
                <div class="card shadow-lg">
                    <div class="card-body text-center p-5">
                        <div class="mb-4">
                            <i class="fas fa-lock fa-3x text-primary"></i>
                        </div>
                        <h3 class="mb-4">Login Required</h3>
                        <p class="text-muted mb-4">
                            You need to log in to access this page. Please choose your login type:
                        </p>
                        
                        <div class="d-grid gap-3">
                            <a href="admin/login.jsp" class="btn btn-primary btn-lg">
                                <i class="fas fa-user-shield me-2"></i>Admin Login
                            </a>
                            <a href="user/login.jsp" class="btn btn-outline-primary btn-lg">
                                <i class="fas fa-user me-2"></i>User Login
                            </a>
                        </div>
                        
                        <div class="mt-4">
                            <a href="index.jsp" class="btn btn-link">
                                <i class="fas fa-arrow-left me-2"></i>Back to Home
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
