<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Scriptlet block to process incoming request data
    // We retrieve all 5 data entry points submitted from the HTML form
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String position = request.getParameter("position");
    String experience = request.getParameter("experience");
    String comments = request.getParameter("comments");

    // Perform basic null checks to ensure clean output if fields are missing
    if (fullName == null || fullName.trim().isEmpty()) fullName = "Not provided";
    if (email == null || email.trim().isEmpty()) email = "Not provided";
    if (position == null) position = "Not provided";
    if (experience == null) experience = "Not provided";
    if (comments == null || comments.trim().isEmpty()) comments = "No cover letter provided";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Application Received</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

    <!-- Overall Data Description and Title -->
    <h1>Application Successfully Submitted</h1>
    <p class="description">
        Thank you for applying. Below is a summary of the candidate data successfully captured by our system.
    </p>

    <!-- Field Descriptions -->
    <div class="field-info">
        <h3>Data Field Descriptions:</h3>
        <ul>
            <li>Applicant Name: The legal name registered to the candidate profile.</li>
            <li>Contact Email: The primary address designated for interview correspondence.</li>
            <li>Role: The specific software engineering requisition applied for.</li>
            <li>Experience Level: The declared bracket of professional industry experience.</li>
            <li>Additional Notes: The provided cover letter or supplementary candidate background.</li>
        </ul>
    </div>

    <!-- Data displayed in an HTML table format -->
    <h2>Candidate Record</h2>
    <table>
        <thead>
            <tr>
                <th>Data Field</th>
                <th>Submitted Value</th>
            </tr>
        </thead>
        <tbody>
            <!-- HTML tags are strictly outside of the scriptlets -->
            <!-- We use JSP expressions to output the variables defined in the scriptlet above -->
            <tr>
                <td>Applicant Name</td>
                <td><%= fullName %></td>
            </tr>
            <tr>
                <td>Contact Email</td>
                <td><%= email %></td>
            </tr>
            <tr>
                <td>Role</td>
                <td><%= position %></td>
            </tr>
            <tr>
                <td>Experience Level</td>
                <td><%= experience %></td>
            </tr>
            <tr>
                <td>Additional Notes</td>
                <td><%= comments %></td>
            </tr>
        </tbody>
    </table>

</body>
</html>