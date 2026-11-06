<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Job Application Form</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <h1>Software Engineering Job Application</h1>
    <p class="description">Please fill out the fields below to submit your candidate profile.</p>
    
    <!-- The form submits via POST to our separate JSP file -->
    <form action="processApplication.jsp" method="POST" class="form-container">
        
        <!-- Input 1: Text type -->
        <label for="fullName">Full Name:</label><br>
        <input type="text" id="fullName" name="fullName" required><br><br>
        
        <!-- Input 2: Email type -->
        <label for="email">Email Address:</label><br>
        <input type="email" id="email" name="email" required><br><br>
        
        <!-- Input 3: Select dropdown type -->
        <label for="position">Desired Position:</label><br>
        <select id="position" name="position">
            <option value="Software Engineer, Factory Software">Software Engineer, Factory Software</option>
            <option value="Data Engineer">Data Engineer</option>
            <option value="Systems Architect">Systems Architect</option>
        </select><br><br>
        
        <!-- Input 4: Radio button type -->
        <label>Years of Professional Experience:</label><br>
        <input type="radio" id="exp1" name="experience" value="0 to 2 Years" required>
        <label for="exp1">0 to 2 Years</label><br>
        
        <input type="radio" id="exp2" name="experience" value="3 to 5 Years">
        <label for="exp2">3 to 5 Years</label><br>
        
        <input type="radio" id="exp3" name="experience" value="5+ Years">
        <label for="exp3">5+ Years</label><br><br>
        
        <!-- Input 5: Textarea type -->
        <label for="comments">Cover Letter or Additional Comments:</label><br>
        <textarea id="comments" name="comments" rows="5" cols="50" placeholder="Briefly describe your background..."></textarea><br><br>
        
        <input type="submit" value="Submit Application">
    </form>
</body>
</html>