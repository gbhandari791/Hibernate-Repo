# NoteTaker

A web-based note-taking application using Hibernate, Servlets, JSP, Bootstrap, jQuery, AJAX, and MySQL.

## Features
- Create, update, view, and delete notes  
- Organize notes into folders  
- AJAX for smooth interactions  

## Tech Stack
- **Backend:**	Java (Servlets), Hibernate, Maven  
- **Frontend:**	JSP, Bootstrap, jQuery, AJAX  
- **Database:**	MySQL (`note_taker` schema)  
- **Runtime:**	Tomcat v9.0

## Setup Instructions

### 1. Clone the repository
```bash
git clone https://github.com/gbhandari791/Hibernate-Repo.git
cd NoteTaker
```

### 2. Create the database and execute required SQLs
- All required SQL scripts are present in the `NoteTaker/database` folder.

### 3. Configure Hibernate
- Update `hibernate.cfg.xml` with your MySQL credentials.

### 4. Import the project in Eclipse (or any preferred IDE)

### 5. Set up Tomcat in Eclipse
- Go to **Project Properties** → **Targeted Runtime** → Select **Tomcat 9**.

### 6. Deploy on Tomcat and access the application at:
```bash
http://localhost:8080/NoteTaker/
```
