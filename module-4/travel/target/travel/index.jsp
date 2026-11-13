<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.javabean.DestinationBean" %>
<%
    // Scriptlet block to hold Java code and instantiate our JavaBeans
    List<DestinationBean> destinationList = new ArrayList<>();
    
    // Creating 5 records using the JavaBean, each containing 5 fields of data
    DestinationBean dest1 = new DestinationBean("Chichen Itza", "Yucatan", "Historical Site", 4.8, "Iconic ancient Mayan city featuring the Temple of Kukulcan.");
    DestinationBean dest2 = new DestinationBean("Teotihuacan", "State of Mexico", "Historical Site", 4.7, "Massive Mesoamerican pyramids known as the Pyramid of the Sun and Moon.");
    DestinationBean dest3 = new DestinationBean("Cancun", "Quintana Roo", "Coastal Resort", 4.5, "World famous white sand beaches and crystal clear Caribbean waters.");
    DestinationBean dest4 = new DestinationBean("Cabo San Lucas", "Baja California Sur", "Coastal Resort", 4.6, "Famous for the Arch where the Pacific meets the Sea of Cortez.");
    DestinationBean dest5 = new DestinationBean("Cenote Dos Ojos", "Quintana Roo", "Natural Wonder", 4.9, "A massive underground cave system filled with fresh water for snorkeling.");
    
    // Adding the JavaBean records to the list for iteration
    destinationList.add(dest1);
    destinationList.add(dest2);
    destinationList.add(dest3);
    destinationList.add(dest4);
    destinationList.add(dest5);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Travel Destinations Data</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>

    <!-- Overall Data Description and Title -->
    <h1>Memorable Destinations in Mexico</h1>
    <p class="description">
        This page displays an organized dataset of travel destinations. The data is stored securely in backend JavaBeans and rendered into this view.
    </p>

    <!-- Field Descriptions -->
    <div class="field-info">
        <h3>Data Field Descriptions:</h3>
        <ul>
            <li>Destination Name: The official name of the location or landmark.</li>
            <li>State or Region: The geographic state where the destination is located.</li>
            <li>Category: The type of attraction.</li>
            <li>Rating: The average visitor rating out of 5.0 stars.</li>
            <li>Highlight Description: A brief summary of what makes the location special.</li>
        </ul>
    </div>

    <!-- Data displayed in an HTML table format -->
    <table>
        <thead>
            <tr>
                <th>Destination Name</th>
                <th>State or Region</th>
                <th>Category</th>
                <th>Visitor Rating</th>
                <th>Highlight Description</th>
            </tr>
        </thead>
        <tbody>
            <!-- Scriptlet to iterate through the JavaBean list -->
            <% 
                for (DestinationBean dest : destinationList) { 
            %>
                <!-- HTML tags are strictly outside of the scriptlet -->
                <tr>
                    <!-- Using JSP expressions to call getter methods on the JavaBean -->
                    <td><%= dest.getDestinationName() %></td>
                    <td><%= dest.getRegion() %></td>
                    <td><%= dest.getCategory() %></td>
                    <td><%= dest.getRating() %></td>
                    <td><%= dest.getDescription() %></td>
                </tr>
            <% 
                } 
            %>
        </tbody>
    </table>

</body>
</html>