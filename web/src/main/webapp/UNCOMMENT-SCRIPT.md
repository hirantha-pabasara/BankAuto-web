# BankAuto - web.xml Uncomment Script

## 🔧 Quick Script to Uncomment Backend Configurations

### For Windows PowerShell:
```powershell
# Navigate to your web.xml directory
cd "C:\Users\Hirantha Pabasara\IdeaProjects\BankAuto\web\src\main\webapp\WEB-INF"

# Create backup
Copy-Item web.xml web.xml.backup

# Uncomment configurations (run these one by one)
(Get-Content web.xml) -replace "<!-- Security Constraints - COMMENTED OUT FOR UI DEVELOPMENT -->", "<!-- Security Constraints -->" | Set-Content web.xml
(Get-Content web.xml) -replace "<!-- Login Configuration - COMMENTED OUT FOR UI DEVELOPMENT -->", "<!-- Login Configuration -->" | Set-Content web.xml
(Get-Content web.xml) -replace "<!-- Security Roles - COMMENTED OUT FOR UI DEVELOPMENT -->", "<!-- Security Roles -->" | Set-Content web.xml
(Get-Content web.xml) -replace "<!-- JSP Configuration - COMMENTED OUT FOR UI DEVELOPMENT -->", "<!-- JSP Configuration -->" | Set-Content web.xml
(Get-Content web.xml) -replace "<!-- Filters - COMMENTED OUT FOR UI DEVELOPMENT -->", "<!-- Filters -->" | Set-Content web.xml
(Get-Content web.xml) -replace "<!-- Listener for Application Initialization - COMMENTED OUT FOR UI DEVELOPMENT -->", "<!-- Listener for Application Initialization -->" | Set-Content web.xml
(Get-Content web.xml) -replace "<!-- Servlet Definitions - COMMENTED OUT FOR UI DEVELOPMENT -->", "<!-- Servlet Definitions -->" | Set-Content web.xml
(Get-Content web.xml) -replace "<!-- Resource References - COMMENTED OUT FOR UI DEVELOPMENT -->", "<!-- Resource References -->" | Set-Content web.xml
(Get-Content web.xml) -replace "<!-- Environment Entries - COMMENTED OUT FOR UI DEVELOPMENT -->", "<!-- Environment Entries -->" | Set-Content web.xml
```

### Manual Method (Recommended):
1. **Open web.xml in your IDE**
2. **Find each section with comments like:**
   ```xml
   <!-- Security Constraints - COMMENTED OUT FOR UI DEVELOPMENT -->
   <!--
   <security-constraint>
   ...
   </security-constraint>
   -->
   ```

3. **Remove the comment blocks:**
   - Delete the line `<!-- Security Constraints - COMMENTED OUT FOR UI DEVELOPMENT -->`
   - Delete the opening `<!--` 
   - Delete the closing `-->`

4. **Result should look like:**
   ```xml
   <!-- Security Constraints -->
   <security-constraint>
   ...
   </security-constraint>
   ```

### Sections to Uncomment:
1. **Security Constraints** (Lines ~84-110)
2. **Login Configuration** (Lines ~112-120)
3. **Security Roles** (Lines ~122-130)
4. **JSP Configuration** (Lines ~132-140)
5. **Filters** (Lines ~142-170)
6. **Listeners** (Lines ~172-180)
7. **Servlet Definitions** (Lines ~182-250)
8. **Resource References** (Lines ~252-260)
9. **Environment Entries** (Lines ~262-280)

### ⚠️ Important Notes:
- **Create a backup** of web.xml before making changes
- **Test after each section** to ensure no errors
- **Only uncomment when backend classes are ready**
- **Check server logs** for any deployment issues

### 🔄 Rollback if Issues:
```powershell
# Restore from backup
Copy-Item web.xml.backup web.xml
```

### 📋 Verification Steps:
After uncommenting, verify:
1. Application deploys without errors
2. All backend classes are found
3. Database connection works
4. Authentication functions properly

---

**Remember:** Only uncomment configurations when your backend implementation is complete and tested!
