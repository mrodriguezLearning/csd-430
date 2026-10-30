<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    // Data Structure to hold the categories and their respective location records
    // The Map keys represent the topical categories
    // The List contains string arrays, representing records with 3 fields each
    Map<String, List<String[]>> travelData = new LinkedHashMap<>();

    // Category 1: Ancient Historical Sites
    List<String[]> historicalSites = new ArrayList<>();
    historicalSites.add(new String[]{"Chichen Itza", "Yucatan", "Iconic ancient Mayan city featuring the Temple of Kukulcan."});
    historicalSites.add(new String[]{"Teotihuacan", "State of Mexico", "Massive Mesoamerican pyramids known as the Pyramid of the Sun and Moon."});
    travelData.put("Ancient Historical Sites", historicalSites);

    // Category 2: Coastal Resorts and Beaches
    List<String[]> coastalResorts = new ArrayList<>();
    coastalResorts.add(new String[]{"Cancun", "Quintana Roo", "World famous white sand beaches and crystal clear Caribbean waters."});
    coastalResorts.add(new String[]{"Cabo San Lucas", "Baja California Sur", "Famous for the Arch of Cabo San Lucas where the Pacific meets the Sea of Cortez."});
    travelData.put("Coastal Resorts and Beaches", coastalResorts);

    // Category 3: Natural Wonders
    List<String[]> naturalWonders = new ArrayList<>();
    naturalWonders.add(new String[]{"Cenote Dos Ojos", "Quintana Roo", "A massive underground cave system filled with fresh water for snorkeling."});
    travelData.put("Natural Wonders", naturalWonders);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Travel Destinations</title>
    <!-- Link to the external CSS stylesheet -->
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

    <!-- Overall Data Description and Title -->
    <h1>Memorable Destinations in Mexico</h1>
    <p class="description">
        This page highlights several incredible locations to visit across Mexico. The data is divided into distinct topical categories based on the type of attraction.
    </p>

    <!-- Field Descriptions -->
    <div class="field-info">
        <h3>Data Field Descriptions:</h3>
        <ul>
            <li>Destination Name: The specific name of the location or landmark.</li>
            <li>State or Region: The geographic state where the destination is located.</li>
            <li>Highlight Description: A brief summary of what makes the location special.</li>
        </ul>
    </div>

    <!-- Iterate through the Map to generate a table for each category -->
    <% 
        for (Map.Entry<String, List<String[]>> entry : travelData.entrySet()) { 
            String currentCategory = entry.getKey();
            List<String[]> locations = entry.getValue();
    %>
        <!-- Display the category name as a section header -->
        <h2><%= currentCategory %></h2>
        
        <!-- Table displaying the records for the current category -->
        <table>
            <thead>
                <tr>
                    <th>Destination Name</th>
                    <th>State or Region</th>
                    <th>Highlight Description</th>
                </tr>
            </thead>
            <tbody>
                <!-- Iterate through the records in the current category list -->
                <% 
                    for (String[] locationRecord : locations) { 
                %>
                    <tr>
                        <!-- Output each field from the Java array into HTML table data cells -->
                        <td><%= locationRecord[0] %></td>
                        <td><%= locationRecord[1] %></td>
                        <td><%= locationRecord[2] %></td>
                    </tr>
                <% 
                    } 
                %>
            </tbody>
        </table>
    <% 
        } 
    %>

</body>
</html>