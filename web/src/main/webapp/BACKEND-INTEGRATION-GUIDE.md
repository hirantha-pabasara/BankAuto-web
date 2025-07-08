# BankAuto - Backend Integration Guide

## 🚀 After Backend Development is Complete

### Phase 1: Uncomment Backend Configurations in web.xml

#### 1.1 Security Constraints
```xml
<!-- Remove comment blocks around these sections -->
<security-constraint>
    <web-resource-collection>
        <web-resource-name>Admin Area</web-resource-name>
        <url-pattern>/admin/*</url-pattern>
        <http-method>GET</http-method>
        <http-method>POST</http-method>
    </web-resource-collection>
    <auth-constraint>
        <role-name>admin</role-name>
    </auth-constraint>
</security-constraint>

<security-constraint>
    <web-resource-collection>
        <web-resource-name>User Area</web-resource-name>
        <url-pattern>/user/dashboard.jsp</url-pattern>
        <url-pattern>/user/createAccount.jsp</url-pattern>
        <url-pattern>/user/viewAccounts.jsp</url-pattern>
        <url-pattern>/user/transactions.jsp</url-pattern>
        <url-pattern>/user/notifications.jsp</url-pattern>
        <http-method>GET</http-method>
        <http-method>POST</http-method>
    </web-resource-collection>
    <auth-constraint>
        <role-name>user</role-name>
    </auth-constraint>
</security-constraint>
```

#### 1.2 Login Configuration
```xml
<login-config>
    <auth-method>FORM</auth-method>
    <form-login-config>
        <form-login-page>/login-redirect.jsp</form-login-page>
        <form-error-page>/login-error.jsp</form-error-page>
    </form-login-config>
</login-config>
```

#### 1.3 Security Roles
```xml
<security-role>
    <role-name>admin</role-name>
</security-role>
<security-role>
    <role-name>user</role-name>
</security-role>
```

#### 1.4 Servlet Mappings
```xml
<!-- All servlet definitions and mappings -->
<servlet>
    <servlet-name>LoginServlet</servlet-name>
    <servlet-class>com.bankauto.servlets.LoginServlet</servlet-class>
</servlet>
<servlet-mapping>
    <servlet-name>LoginServlet</servlet-name>
    <url-pattern>/login</url-pattern>
</servlet-mapping>
<!-- ... and all other servlets -->
```

#### 1.5 Filters
```xml
<filter>
    <filter-name>CharacterEncodingFilter</filter-name>
    <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
    <!-- ... -->
</filter>

<filter>
    <filter-name>SecurityHeadersFilter</filter-name>
    <filter-class>com.bankauto.filters.SecurityHeadersFilter</filter-class>
</filter>
```

#### 1.6 Listeners
```xml
<listener>
    <listener-class>com.bankauto.listeners.AppContextListener</listener-class>
</listener>
```

#### 1.7 Database Resources
```xml
<resource-ref>
    <res-ref-name>jdbc/BankAutoDB</res-ref-name>
    <res-type>javax.sql.DataSource</res-type>
    <res-auth>Container</res-auth>
</resource-ref>
```

#### 1.8 JSP Configuration
```xml
<jsp-config>
    <jsp-property-group>
        <url-pattern>*.jsp</url-pattern>
        <include-prelude>/WEB-INF/jsp/includes/header.jspf</include-prelude>
        <include-coda>/WEB-INF/jsp/includes/footer.jspf</include-coda>
    </jsp-property-group>
</jsp-config>
```

### Phase 2: Update JSP Files

#### 2.1 Update Form Actions
Change static form actions to backend servlet URLs:

**Before (Current UI-only):**
```html
<form action="#" method="post">
```

**After (Backend Integration):**
```html
<form action="${pageContext.request.contextPath}/login" method="post">
<form action="${pageContext.request.contextPath}/user/api/createAccount" method="post">
<form action="${pageContext.request.contextPath}/admin/api/approveAccount" method="post">
```

#### 2.2 Add CSRF Protection
```html
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
```

#### 2.3 Update Data Display
Replace static sample data with dynamic data:

**Before:**
```html
<td>John Doe</td>
<td>john@example.com</td>
<td>$5,000.00</td>
```

**After:**
```html
<td>${user.name}</td>
<td>${user.email}</td>
<td>$${account.balance}</td>
```

#### 2.4 Add Session Management
```html
<%
    String username = (String) session.getAttribute("username");
    String userRole = (String) session.getAttribute("userRole");
    if (username == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
```

### Phase 3: Backend Classes to Implement

#### 3.1 Servlets
Create these servlet classes in `src/main/java/com/bankauto/servlets/`:

- `LoginServlet.java`
- `LogoutServlet.java`
- `AdminServlet.java`
- `UserServlet.java`
- `AccountServlet.java`
- `TransactionServlet.java`

#### 3.2 Filters
Create these filter classes in `src/main/java/com/bankauto/filters/`:

- `SecurityHeadersFilter.java`
- `AuthenticationFilter.java`
- `AuthorizationFilter.java`

#### 3.3 Listeners
Create these listener classes in `src/main/java/com/bankauto/listeners/`:

- `AppContextListener.java`

#### 3.4 Data Access Objects (DAOs)
Create DAO classes in `src/main/java/com/bankauto/dao/`:

- `UserDAO.java`
- `AccountDAO.java`
- `TransactionDAO.java`
- `AdminDAO.java`

#### 3.5 Model Classes
Create model classes in `src/main/java/com/bankauto/model/`:

- `User.java`
- `Account.java`
- `Transaction.java`
- `Admin.java`

#### 3.6 Service Classes
Create service classes in `src/main/java/com/bankauto/service/`:

- `UserService.java`
- `AccountService.java`
- `TransactionService.java`
- `AdminService.java`

### Phase 4: Database Configuration

#### 4.1 Database Setup
1. Create database schema
2. Create tables for users, accounts, transactions, etc.
3. Insert sample data for testing

#### 4.2 Connection Pool Configuration
Configure JNDI database connection in your application server:

**For Tomcat (context.xml):**
```xml
<Resource name="jdbc/BankAutoDB" 
          auth="Container" 
          type="javax.sql.DataSource"
          maxTotal="100" 
          maxIdle="30" 
          maxWaitMillis="10000"
          driverClassName="com.mysql.cj.jdbc.Driver"
          url="jdbc:mysql://localhost:3306/bankauto"
          username="your_username" 
          password="your_password" />
```

#### 4.3 Required Dependencies
Add these to your `pom.xml` or `build.gradle`:

- Database driver (MySQL, PostgreSQL, etc.)
- JSTL for JSP
- JSON processing library
- Validation libraries
- Logging framework

### Phase 5: Security Configuration

#### 5.1 User Roles in Application Server
Configure user roles in your application server:

**For Tomcat (tomcat-users.xml):**
```xml
<tomcat-users>
    <role rolename="admin"/>
    <role rolename="user"/>
    <user username="admin" password="admin123" roles="admin"/>
    <user username="user1" password="user123" roles="user"/>
</tomcat-users>
```

#### 5.2 Password Security
- Implement password hashing (BCrypt)
- Add password strength validation
- Implement account lockout after failed attempts

### Phase 5: EJB Module Dependencies

#### 5.1 Maven Dependencies (pom.xml)

**Core Module:**
```xml
<dependencies>
    <dependency>
        <groupId>javax.persistence</groupId>
        <artifactId>javax.persistence-api</artifactId>
        <version>2.2</version>
    </dependency>
    <dependency>
        <groupId>javax.validation</groupId>
        <artifactId>validation-api</artifactId>
        <version>2.0.1.Final</version>
    </dependency>
</dependencies>
```

**Auth-EJB Module:**
```xml
<dependencies>
    <dependency>
        <groupId>com.bankauto</groupId>
        <artifactId>core</artifactId>
        <version>1.0.0</version>
    </dependency>
    <dependency>
        <groupId>javax.ejb</groupId>
        <artifactId>javax.ejb-api</artifactId>
        <version>3.2.2</version>
    </dependency>
</dependencies>
```

**Account-EJB Module:**
```xml
<dependencies>
    <dependency>
        <groupId>com.bankauto</groupId>
        <artifactId>core</artifactId>
        <version>1.0.0</version>
    </dependency>
    <dependency>
        <groupId>javax.ejb</groupId>
        <artifactId>javax.ejb-api</artifactId>
        <version>3.2.2</version>
    </dependency>
</dependencies>
```

**Web Module:**
```xml
<dependencies>
    <dependency>
        <groupId>com.bankauto</groupId>
        <artifactId>core</artifactId>
        <version>1.0.0</version>
    </dependency>
    <dependency>
        <groupId>com.bankauto</groupId>
        <artifactId>auth-ejb</artifactId>
        <version>1.0.0</version>
        <type>ejb</type>
    </dependency>
    <dependency>
        <groupId>com.bankauto</groupId>
        <artifactId>account-ejb</artifactId>
        <version>1.0.0</version>
        <type>ejb</type>
    </dependency>
</dependencies>
```

### Phase 6: EJB Integration Steps

#### 6.1 Complete EJB Module Development
1. **Core Module**: Complete all entities, DTOs, and utilities
2. **Auth-EJB**: Complete authentication and user management services
3. **Account-EJB**: Complete account and transaction services
4. **Test EJB modules**: Unit test all EJB services

#### 6.2 Update Web Module
1. **Uncomment EJB References** in web.xml
2. **Update Servlet Classes** to use @EJB injection
3. **Update JSP Files** to use dynamic data
4. **Test Integration** between web and EJB layers

#### 6.3 EAR Module Configuration
1. **Configure application.xml** with all modules
2. **Set up persistence.xml** with JPA configuration
3. **Configure data sources** in application server
4. **Deploy EAR** to application server

### Phase 7: Testing Strategy

#### 7.1 Unit Testing (Per Module)
- Test each EJB module independently
- Test core entities and DTOs
- Test utility classes

#### 7.2 Integration Testing
- Test web layer with EJB services
- Test database operations
- Test authentication flow

#### 7.3 System Testing
- Test complete user workflows
- Test admin functionalities
- Test error scenarios

### Phase 8: Deployment Process

#### 8.1 Build Order
1. **Core Module** (jar)
2. **Auth-EJB Module** (ejb-jar)
3. **Account-EJB Module** (ejb-jar)
4. **Web Module** (war)
5. **EAR Module** (ear)

#### 8.2 Deployment Steps
1. **Configure Application Server** (GlassFish/WildFly)
2. **Set up Database** and data sources
3. **Deploy EAR** to server
4. **Test Application** end-to-end

## 🎯 EJB-Specific Benefits

### Enterprise Features:
- **Transaction Management**: Automatic JTA transactions
- **Security**: Container-managed security
- **Scalability**: Distributed computing capabilities
- **Reliability**: Container-managed lifecycle
- **Performance**: Connection pooling and caching

### Development Benefits:
- **Separation of Concerns**: Clean architecture
- **Reusability**: EJB services can be reused
- **Testability**: Independent module testing
- **Maintainability**: Modular structure

## 📋 EJB Integration Checklist

### Pre-Integration:
- [ ] All EJB modules compile successfully
- [ ] Core entities and DTOs are complete
- [ ] EJB services are implemented and tested
- [ ] Database schema is created
- [ ] Application server is configured

### During Integration:
- [ ] Uncomment EJB references in web.xml
- [ ] Update servlet classes with @EJB injection
- [ ] Update JSP files with dynamic data
- [ ] Test each module integration step by step

### Post-Integration:
- [ ] All user workflows function correctly
- [ ] Admin functionalities work properly
- [ ] Error handling is working
- [ ] Performance is acceptable
- [ ] Security is properly implemented

---

**Next Steps:** Start implementing your backend classes and follow this guide step by step for smooth integration!
