# Struts Product Catalog (Mini Project)

A Java web application built with **Apache Struts 1**, **JSP**, **Servlets**, **MySQL**, and **Tomcat 9**. The project supports a modern product catalog interface with:

* View products
* Add products
* Edit products
* Delete products
* Search and sort products
* Toast notifications
* Responsive mobile-friendly UI
* Animated delete confirmation modal

---

## Project Overview

This project is a **CRUD-based mini project** using the MVC architecture.

### Architecture

* **Model**: `Product.java`
* **View**: JSP pages
* **Controller**: Struts Actions
* **Database**: MySQL
* **Server**: Apache Tomcat 9

---

## Main Features

* Modern responsive UI
* Product listing with search and sort
* Add new product
* Update existing product
* Delete product with animated confirmation popup
* Toast messages after actions
* Smooth loading animation
* Shared MySQL database support

---

## Technologies Used

* Java 11
* Apache Tomcat 9.0.117
* Apache Struts 1.3
* MySQL 9.x / MySQL 8.x compatible JDBC
* JSP
* Servlet
* HTML5
* CSS3
* JavaScript

---

## Project Structure

```text
StrutsProductCatalog/
├── addProduct.jsp
├── editProduct.jsp
├── index.jsp
├── products.jsp
├── README.md
├── db/
│   └── productdb.sql
├── src/
│   └── com/
│       └── project/
│           ├── action/
│           ├── dao/
│           ├── model/
│           └── util/
└── WEB-INF/
    ├── classes/
    ├── lib/
    ├── struts-config.xml
    └── web.xml
```

---

## Required Software

Before running the project, install the following:

1. **Java JDK 11**
2. **Apache Tomcat 9**
3. **MySQL Server**
4. **MySQL JDBC Connector JAR**
5. **Git** (optional, only for cloning/pushing project)

---

## Important Files

### Java files

* `DBConnection.java` → database connection
* `ProductDAO.java` → database CRUD logic
* `Product.java` → model class
* `ProductAction.java` → loads products
* `AddProductAction.java` → inserts product
* `EditProductAction.java` → fetches product for editing
* `UpdateProductAction.java` → updates product
* `DeleteProductAction.java` → deletes product

### JSP files

* `index.jsp` → home page
* `products.jsp` → product list page
* `addProduct.jsp` → add product page
* `editProduct.jsp` → edit product page

---

## Database Setup

### Database Name

```sql
productdb
```

### Table Name

```sql
products
```

### Table Structure

```sql
CREATE TABLE products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price DOUBLE NOT NULL
);
```

---

## SQL File for Setup

A database dump file is included in:

```text
db/productdb.sql
```

This file contains:

* table structure
* sample/default data

---

## How to Import the Database

### Option 1: Using MySQL Command Line

1. Open Command Prompt
2. Login to MySQL:

```bash
mysql -u root -p
```

3. Create the database:

```sql
CREATE DATABASE productdb;
```

4. Exit MySQL:

```sql
exit;
```

5. Import the SQL file from the project folder:

```bash
mysql -u root -p productdb < db/productdb.sql
```

---

### Option 2: Using MySQL Workbench

1. Open MySQL Workbench
2. Open SQL File or Data Import
3. Select `db/productdb.sql`
4. Run the import

---

## DBConnection Configuration

Open:

```text
src/com/project/util/DBConnection.java
```

Update these values if needed:

```java
private static final String URL = "jdbc:mysql://localhost:3306/productdb?useSSL=false&serverTimezone=UTC";
private static final String USER = "root";
private static final String PASSWORD = "your_password_here";
```

### Important

* `productdb` must exist in MySQL
* Username and password must match your local MySQL setup
* If you share this project with someone else, they must update their own password in `DBConnection.java`

---

## MySQL Connector JAR

The following JAR must be placed in:

```text
WEB-INF/lib/
```

Required file:

```text
mysql-connector-j-8.x.x.jar
```

Without this, JDBC connection will fail.

---

## How to Run the Project Locally

### Step 1: Copy project to Tomcat webapps folder

Place the project folder inside:

```text
E:\apache-tomcat-9.0.117\webapps\
```

The application folder should be:

```text
StrutsProductCatalog
```

---

### Step 2: Compile Java files

Run these commands inside the project folder:

```bash
javac -d WEB-INF/classes src/com/project/util/DBConnection.java
javac -d WEB-INF/classes src/com/project/model/Product.java
javac -cp "WEB-INF/classes;WEB-INF/lib/*" -d WEB-INF/classes src/com/project/dao/ProductDAO.java
javac -cp "WEB-INF/classes;WEB-INF/lib/*;E:\apache-tomcat-9.0.117\lib\servlet-api.jar" -d WEB-INF/classes src/com/project/action/*.java
```

---

### Step 3: Start Tomcat

Open Command Prompt and run:

```bash
cd E:\apache-tomcat-9.0.117\bin
.\catalina.bat run
```

---

### Step 4: Open the project in browser

Use this URL:

```text
http://localhost:8080/StrutsProductCatalog/
```

Or open directly:

```text
http://localhost:8080/StrutsProductCatalog/products.do
```

---

## How to Use the Application

### View Products

Open the home page or `products.do` to see the product list.

### Add Product

Click **Add Product**, enter name and price, then submit.

### Edit Product

Click **Edit** beside a product, update fields, and save.

### Delete Product

Click **Delete**, confirm in the popup, and the product will be removed.

### Search and Sort

Use the search box and sorting dropdown on the product page.

---

## Mobile-Friendly Design

The UI is optimized for:

* mobile browsers
* tablets
* desktop screens

Responsive features include:

* compact spacing
* adaptive buttons
* cleaner list layout
* scroll-friendly design
* mobile-safe input fields

---

## GitHub Setup

### Clone the repository

```bash
git clone <your-repository-url>
```

### Commit changes

```bash
git add .
git commit -m "your message"
git push origin main
```

---

## Sharing With Another Person

If another person wants to run this project on their PC, they need:

* Java 11
* Tomcat 9
* MySQL
* JDBC connector JAR
* the project code
* `db/productdb.sql`
* their own MySQL username/password in `DBConnection.java`

### Important

GitHub does **not** transfer your installed MySQL server or your local database automatically. The `.sql` file must be imported on their machine.

---

## Common Problems and Fixes

### 1. 404 Error

* Check Tomcat is running
* Check the URL is correct
* Make sure the app folder name is `StrutsProductCatalog`

### 2. Database Connection Failed

* Check MySQL is running
* Check database name is `productdb`
* Check username/password in `DBConnection.java`
* Check JDBC connector JAR exists in `WEB-INF/lib`

### 3. JSP Compilation Error

* Check the JSP syntax carefully
* Restart Tomcat after editing files
* Recompile Java files if needed

### 4. Delete/Add/Update Not Working

* Check the action mappings in `struts-config.xml`
* Check DAO methods are updated correctly
* Restart Tomcat after code changes

---

## Notes

* This project uses **MySQL database**, not session-based storage.
* Product data is shared by all users who connect to the same database.
* If your friend uses their own MySQL database, they may see different data unless they import the same SQL file.

---

## Author / Credit

Project designed by **Pratik N Chakraborty**

---

## Version

Current version: 1.0

---

## License

This is a mini project for learning and academic use.
