<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Application Error - BankAuto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="../css/main.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid vh-100 d-flex align-items-center justify-content-center">
        <div class="row">
            <div class="col-12 text-center">
                <div class="error-container">
                    <div class="error-icon mb-4">
                        <i class="fas fa-bug fa-5x text-warning"></i>
                    </div>
                    <h1 class="display-2 fw-bold text-warning">Oops!</h1>
                    <h2 class="mb-4">Something went wrong</h2>
                    <p class="lead mb-4">
                        An unexpected error occurred. Our team has been notified.
                    </p>
                    <div class="error-actions">
                        <a href="../index.jsp" class="btn btn-primary btn-lg me-3">
                            <i class="fas fa-home me-2"></i>Go Home
                        </a>
                        <button onclick="history.back()" class="btn btn-outline-secondary btn-lg">
                            <i class="fas fa-arrow-left me-2"></i>Go Back
                        </button>
                    </div>
                    
                    <% if (exception != null) { %>
                        <div class="mt-4">
                            <details class="text-start">
                                <summary class="btn btn-sm btn-outline-secondary">Technical Details</summary>
                                <div class="mt-3 p-3 bg-light rounded">
                                    <small class="text-muted">
                                        <strong>Exception:</strong> <%= exception.getClass().getSimpleName() %><br>
                                        <strong>Message:</strong> <%= exception.getMessage() %><br>
                                        <strong>Time:</strong> <%= new java.util.Date() %>
                                    </small>
                                </div>
                            </details>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
