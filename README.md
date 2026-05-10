# BankAuto Web

BankAuto Web is a multi-module Jakarta EE banking application built with Maven.  
It includes user and admin web flows, EJB-based business services, JPA persistence, and EAR packaging for deployment.

## Table of Contents
- [Overview](#overview)
- [Key Features](#key-features)
- [Architecture](#architecture)
- [Technology Stack](#technology-stack)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Configuration](#configuration)
- [Build and Test](#build-and-test)
- [Deployment](#deployment)
- [Main Web Endpoints](#main-web-endpoints)
- [Security Notes](#security-notes)
- [Development Notes](#development-notes)

## Overview
The project is organized as a Maven reactor with five modules:
- `core` (shared domain, DTOs, services, utilities, persistence)
- `account` (EJB module for account/transaction/interest operations)
- `auth` (EJB module for authentication and user/admin session operations)
- `web` (WAR module with JSP views and servlet controllers)
- `ear` (EAR module bundling EJB and WAR artifacts for application server deployment)

## Key Features
- Role-based user and admin flows
- User registration/login and admin registration/login/verification
- Account creation and account detail retrieval
- Transaction history and transfer-related backend services
- Interest-rate initialization and update flows
- Scheduled interest processing (timer-based EJB jobs)
- JSP-based UI with CSS/JS assets

## Architecture
- **Presentation layer**: JSP pages + Servlets (`web` module)
- **Business layer**: Stateless/Singleton EJBs (`account`, `auth` modules)
- **Core layer**: Shared models, services, DTOs, enums, interceptors (`core` module)
- **Persistence**: JPA persistence unit `BankAutoPU` with JTA datasource `jdbc/BankAutoPool`
- **Packaging**: EAR assembly (`ear` module), context root configured as `/bankauto`

## Technology Stack
- Java 11
- Maven (multi-module build)
- Jakarta EE 10 APIs
- JSP/JSTL
- Jakarta Persistence (JPA, EclipseLink properties present)
- EJB (including scheduled jobs)
- Gson
- BCrypt

## Project Structure
```text
BankAuto-web/
├── pom.xml                     # Parent reactor
├── core/                       # Shared domain + services + persistence config
├── account/                    # Account/transaction/interest EJBs
├── auth/                       # Authentication/user session EJBs
├── web/                        # WAR module (JSP + Servlets + static assets)
│   └── src/main/webapp/        # JSP views, CSS, JS, WEB-INF/web.xml
└── ear/                        # EAR packaging module
```

## Prerequisites
- JDK 11+
- Maven 3.8+
- Jakarta EE compatible application server (for example, Payara or WildFly)
- Configured JTA datasource matching `jdbc/BankAutoPool`

## Configuration
Main configuration locations:
- `core/src/main/resources/META-INF/persistence.xml`
- `core/src/main/resources/application.properties`
- `web/src/main/webapp/WEB-INF/web.xml`

Recommended setup:
1. Configure datasource `jdbc/BankAutoPool` in your application server.
2. Update email and related app properties in `application.properties` for your environment.
3. Ensure server security/realm configuration supports roles used by the app (`SUPER_ADMIN`, `ADMIN`, `USER`) if required by your deployment model.

## Build and Test
From repository root:

```bash
mvn clean test
mvn clean package
```

Artifacts are produced per module under each `target/` directory, including EAR output in `ear/target/`.

## Deployment
Typical deployment flow:
1. Build with `mvn clean package`.
2. Deploy the generated EAR from `ear/target/` to your Jakarta EE server.
3. Access the app using the configured context root:
   - `http://<host>:<port>/bankauto`

If your server uses a different deployment mapping, adjust URL accordingly.

## Main Web Endpoints
Examples of servlet mappings in the `web` module:

### User
- `/user/register`
- `/user/login`
- `/user/logout`
- `/user/account-creation`
- `/user/account-details`
- `/user/history`

### Admin
- `/admin/register`
- `/admin/login`
- `/admin/verify`
- `/admin/account-approval`
- `/admin/interest-rates`
- `/admin/initialize-rates`
- `/admin/update-interest`
- `/admin/trigger-interest`

### API
- `/api/pendingAccounts`

## Security Notes
- Security constraints and role declarations are defined in `web.xml`.
- Session timeout is configured in `web.xml`.
- Password handling utilities exist in `core` (BCrypt dependency included).
- Review all local credentials/secrets before production deployment and replace with environment-specific secure values.

## Development Notes
- The project is built as an enterprise multi-module application (EAR + EJB + WAR).
- The `web/src/main/webapp/README.md` contains additional UI-oriented notes.
- For production readiness, ensure:
  - secure secret management,
  - hardened server configuration,
  - proper TLS/HTTPS setup,
  - and environment-specific database/mail settings.
