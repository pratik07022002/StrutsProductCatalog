# Struts Product Catalog (Mini Project)

## Overview

This is a Java-based web application built using **Apache Struts (MVC architecture)** with **Servlets and JSP**.

The application allows users to:

* View products
* Add new products
* Edit existing products
* Delete products

All data is stored in **session memory** (no database is used).

---

## Tech Stack

* Java (JDK 11 recommended)
* Apache Tomcat 9
* Apache Struts 1.3
* JSP & Servlet
* HTML, CSS (custom modern UI)

---

## Project Structure

```
StrutsProductCatalog/
├── index.jsp
├── addProduct.jsp
├── editProduct.jsp
├── products.jsp
├── WEB-INF/
│   ├── web.xml
│   ├── struts-config.xml
│   ├── lib/ (all required JAR files)
│   └── classes/ (compiled .class files)
├── src/ (Java source code)
```

---

## Requirements (IMPORTANT)

Before running the project, make sure you have:

1. Java Installed
   Check:

   ```
   java -version
   ```

   Recommended: Java 11

2. Apache Tomcat Installed
   Recommended: Tomcat 9

3. Environment Variables (optional but recommended)

   * JAVA_HOME → path to JDK
   * PATH → include Java bin folder

---

## How to Run the Project

### Option 1: Using WAR file (Easiest)

1. Copy the `.war` file into:

   ```
   apache-tomcat/webapps/
   ```

2. Start Tomcat:

   ```
   cd apache-tomcat/bin
   catalina.bat run
   ```

3. Open browser:

   ```
   http://localhost:8080/StrutsProductCatalog/
   ```

---

### Option 2: Using Project Folder

1. Copy full project folder:

   ```
   StrutsProductCatalog
   ```

   into:

   ```
   apache-tomcat/webapps/
   ```

2. Start Tomcat:

   ```
   catalina.bat run
   ```

3. Open:

   ```
   http://localhost:8080/StrutsProductCatalog/
   ```

---

## Features

* Add Product
  Add new products with name and price

* View Products
  Displays all products in a styled table

* Edit Product
  Update product details

* Delete Product
  Uses a modern animated confirmation popup

* Modern UI
  Glassmorphism design with animations and loader

---

## Important Notes

* Data is stored in **session only**

  * Refresh → data remains
  * Restart server → data is lost

* No database is used (intentionally for mini project)

* Make sure:

  * All `.do` URLs are used (not `.jsp` directly)
  * JAR files exist in `WEB-INF/lib`
  * `.class` files exist in `WEB-INF/classes`

---

## Common Issues & Fixes

### 1. 404 Error

* Check URL:

  ```
  http://localhost:8080/StrutsProductCatalog/products.do
  ```

### 2. Class Not Found Error

* Make sure `.class` files are compiled properly

### 3. Struts Errors

* Ensure JAR files are present in:

  ```
  WEB-INF/lib
  ```

### 4. Changes Not Reflecting

* Restart Tomcat after changes

---

## Compilation (if editing Java code)

Run inside project folder:

```
javac -cp "WEB-INF/classes;WEB-INF/lib/*;TOMCAT/lib/servlet-api.jar" -d WEB-INF/classes src/com/project/action/*.java
```

Replace `TOMCAT` with your actual Tomcat path.

---

## Project Details

Project Name: Struts Product Catalog (Mini Project)
Architecture: MVC (Struts Framework)

---

## Credits

Project Designed by Pratik N Chakraborty
© April 2026

---

## Final Note

This project is designed for learning purposes to understand:

* Struts MVC flow
* Session handling
* JSP + Servlet integration
* Basic CRUD operations

For real-world use, you should:

* Add database (MySQL)
* Add validation
* Add authentication system

---
