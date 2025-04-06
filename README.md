# TechBlog
# 📝 Tech Blog Website

A secure and dynamic blogging platform built using **Java Servlets**, **JSP**, and **JWT** for authentication. This project allows users to register, log in, and manage blog posts with full CRUD (Create, Read, Update, Delete) operations.

## 🚀 Features

- 🔐 JWT-based user authentication
- ✍️ Create, edit, delete blog posts
- 🧑‍💻 User registration and login system
- 🧹 Session and input validation handling
- 🎨 Responsive and clean frontend design
- ☁️ Deployed using Render with Git integration

---

## 🧱 Tech Stack

### 🖥️ Frontend
- HTML
- CSS
- JavaScript

### 🛠️ Backend
- Java
- Servlets
- JSP
- JDBC
- JWT (io.jsonwebtoken v0.12.5)
- MySQL

### ⚙️ Tools & Deployment
- Git & GitHub
- Render (Cloud Deployment)
- Apache Tomcat (for local testing)

---

## 📸 Screenshots

> _Include screenshots or a demo gif here if available_  
*(Optional but highly recommended)*

---

## 🛠️ Installation & Run Locally

### Prerequisites
- Java JDK 8 or above
- Apache Tomcat server
- MySQL
- Maven (if using)
- Any IDE (like IntelliJ IDEA, Eclipse)

### Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/tech-blog.git
   cd tech-blog


Set up MySQL Database

Create a database named tech_blog.

Run the SQL script from database.sql (if provided) to set up tables.

Configure JDBC Connection

Update your DB credentials in the JDBC config file (DBConnection.java or similar).

Deploy the project

Import the project into your IDE.

Build and run it on Tomcat.

Access the app at: http://localhost:8080/tech-blog

🧪 Project Structure
css
Copy
Edit
tech-blog/
│
├── src/
│   ├── com.techblog.servlets/
│   ├── com.techblog.dao/
│   ├── com.techblog.entities/
│   ├── com.techblog.helper/
│
├── WebContent/
│   ├── css/
│   ├── js/
│   ├── images/
│   ├── pages/
│   └── index.jsp
│
└── README.md
📌 Future Improvements
Add comment system for blog posts

Like/Bookmark functionality

Rich text editor for blog post content

Admin dashboard

REST API version (Spring Boot upgrade)

🤝 Contributing
Pull requests are welcome! For major changes, please open an issue first to discuss what you’d like to change.

📄 License
This project is licensed under the MIT License. See the LICENSE file for details.

🙋‍♂️ Author
Renish Limbasiya
📧 renishlimbasiya@example.com
🔗 LinkedIn | GitHub
