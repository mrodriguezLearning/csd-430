<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.states.StateBean" %>
<%--
    Marco Rodriguez
    11/27/2026
    CSD430 States project page.
    Loads U.S. state records through StateBean for display in the
    selected-record panel and the complete-records table.
--%>
<%
    // Initialize the data-access bean and the bean used for the selected state.
    StateBean dao = new StateBean();
    StateBean activeState = new StateBean();

    // Restrict mode values to the supported page modes.
    String mode = request.getParameter("mode");
    if (mode == null || (!"select".equals(mode) && !"create".equals(mode) && !"update".equals(mode) && !"delete".equals(mode))) {
        mode = "select";
    }

    String dbAction = request.getParameter("action");
    String buttonAction = request.getParameter("submittedAction");
    String jsAction = request.getParameter("jsAction");
    String effectiveAction = (buttonAction != null && !buttonAction.trim().isEmpty())
        ? buttonAction.trim()
        : (jsAction != null ? jsAction.trim() : "");

    String rawId = request.getParameter("stateId");
    String stateName = request.getParameter("stateName");
    String capitalCity = request.getParameter("capitalCity");
    String region = request.getParameter("region");
    String rawRating = request.getParameter("visitorRating");
    String highlights = request.getParameter("highlights");

    String statusMessage = null;
    boolean isError = false;

    // Convert the submitted state ID to an integer when it is present.
    int parsedId = 0;
    boolean hasValidId = false;
    if (rawId != null && !rawId.trim().isEmpty()) {
        try {
            parsedId = Integer.parseInt(rawId.trim());
            hasValidId = true;
        } catch (NumberFormatException ex) {
            hasValidId = false;
        }
    }

    // Convert the submitted visitor rating to a double when it is present.
    double parsedRating = 0.0;
    boolean hasValidRating = false;
    if (rawRating != null && !rawRating.trim().isEmpty()) {
        try {
            parsedRating = Double.parseDouble(rawRating.trim());
            hasValidRating = true;
        } catch (NumberFormatException ex) {
            hasValidRating = false;
        }
    }


    // Load the matching state, or leave activeState empty when no ID was selected.
    try {
        if ("loadSelected".equals(effectiveAction)) {
            if (hasValidId) {
                StateBean loaded = new StateBean();
                if (loaded.loadStateById(parsedId)) {
                    activeState = loaded;
                    statusMessage = "Loaded record for State ID " + parsedId + ".";
                } else {
                    statusMessage = "No state record found for ID " + parsedId + ".";
                    isError = true;
                }
            } else {
                activeState = new StateBean();
            }
        }else if ("applyCreate".equals(effectiveAction)) {
            // Retrieve the input values for state creation.
            String cleanName = stateName != null ? stateName.trim() : "";
            String cleanCapital = capitalCity != null ? capitalCity.trim() : "";
            String cleanRegion = region != null ? region.trim() : "";
            String cleanHighlights = highlights != null ? highlights.trim() : "";

            if (cleanName.isEmpty() || cleanCapital.isEmpty() || cleanRegion.isEmpty() || !hasValidRating || cleanHighlights.isEmpty()) {
                statusMessage = "Please fill in State Name, Capital City, Region, a valid numeric Rating, and Highlights.";
                isError = true;
                activeState.setStateName(cleanName);
                activeState.setCapitalCity(cleanCapital);
                activeState.setRegion(cleanRegion);
                if (hasValidRating) {
                    activeState.setVisitorRating(parsedRating);
                }
                activeState.setHighlights(cleanHighlights);
            } else {
                StateBean newRecord = new StateBean(0, cleanName, cleanCapital, cleanRegion, parsedRating, cleanHighlights);
                int createdId = newRecord.insertState();
                statusMessage = "Created new state record with State ID " + createdId + ".";
                activeState = new StateBean();
            }
        }
        
    } catch (Exception ex) {
        statusMessage = "Database error: " + ex.getMessage();
        isError = true;
    }

    // Execute actions from when requested.
    try {
        // Create Table
        if ("createTable".equals(dbAction)) {
            dao.createTable();
            statusMessage = "Table marco_states_data created or verified in CSD430.";
            activeState = new StateBean();
        }
        // Populate Table 
        else if ("populateTable".equals(dbAction)) {
            dao.createTable();
            dao.populateTable();
            statusMessage = "Table marco_states_data populated with sample state records.";
            activeState = new StateBean();
        } 
        // Drop Table
        else if ("dropTable".equals(dbAction)) {
            dao.dropTable();
            statusMessage = "Table marco_states_data dropped from CSD430.";
            activeState = new StateBean();
        } 
        // Load Selected Record
        else if ("loadSelected".equals(effectiveAction)) {
            if (hasValidId) {
                StateBean loaded = new StateBean();
                if (loaded.loadStateById(parsedId)) {
                    activeState = loaded;
                    statusMessage = "Loaded record for State ID " + parsedId + ".";
                } else {
                    statusMessage = "No state record found for ID " + parsedId + ".";
                    isError = true;
                }
            } else {
                activeState = new StateBean();
            }
        }
    } catch (Exception ex) {
        statusMessage = "Database error: " + ex.getMessage();
        isError = true;
    }

    // Load all states once for the dropdown and complete-records table.
    List<StateBean> allStates = new ArrayList<>();
    try {
        allStates = dao.getAllStates();
    } catch (Exception ex) {
        statusMessage = "Unable to load records from marco_states_data: " + ex.getMessage();
        isError = true;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>CSD430 States Project</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script>
        // JavaScript functions to handle mode switching and dropdown changes
        function switchMode(newMode) {
            var form = document.getElementById("stateForm");
            document.getElementById("modeField").value = newMode;
            form.submit();
        }
        // Handle dropdown change to load the selected state record
        function handleDropdownChange() {
            var form = document.getElementById("stateForm");
            var currentMode = document.getElementById("modeField").value;
            if (currentMode === "select" || currentMode === "update" || currentMode === "delete") {
                document.getElementById("jsActionField").value = "loadSelected";
                form.submit();
            }
        }
    </script>
</head>
<body>
    <h1>CSD430 States Project</h1>
    <p class="description">
        Overall Data Description: Working with CRUD-READ, JDBC & JavaBeans - Project U.S. state records in CSD430 table marco_states_data, with a complete table of all stored records at the bottom.
    </p>

    <div class="field-info">
        <h3>Record and Field Descriptions:</h3>
        <p>
            Record Description: Each record represents one U.S. state profile stored in marco_states_data using six fields. Use the top buttons to switch between Select Record, Create New, Update Record, and Delete Record.
        </p>
        <ul>
            <li>State ID (state_id): Unique primary key identifying each state record.</li>
            <li>State Name (state_name): Official name of the U.S. state.</li>
            <li>Capital City (capital_city): Capital city of the state.</li>
            <li>Region (region): Geographic region where the state is located.</li>
            <li>Visitor Rating (visitor_rating): Numeric visitor rating out of 5.0.</li>
            <li>Highlights (highlights): Key attractions and features of the state.</li>
        </ul>
        <br />
        <!-- Additional functionality for database management is provided through the buttons below, allowing you to create, populate, or drop the marco_states_data table as needed. -->
        <form id="dbUpdateForm" action="index.jsp" method="POST" class="form-container">
            <div class="top-buttons">
                <p>For easy database reset here are the options:(sql files are in the zip archive as well)</p>
                <button type="submit" name="action" value="createTable">Create Table</button>
                <button type="submit" name="action" value="populateTable">Populate Table</button>
                <button type="submit" name="action" value="dropTable">Drop Table</button>
            </div>
        </form>
    </div>

<%
    // Display status messages if present
    if (statusMessage != null) {
        if (isError) {
%>
    <p class="error-msg"><%= statusMessage %></p>
<%
        } else {
%>
    <p class="field-info"><%= statusMessage %></p>
<%
        }
    }
%>

    <form id="stateForm" action="index.jsp" method="POST" class="form-container">
        <input type="hidden" id="modeField" name="mode" value="<%= mode %>">
        <input type="hidden" id="jsActionField" name="jsAction" value="">

        <div class="top-buttons">
            <button type="button" onclick="switchMode('select')">Select Record</button>
            <button type="button" onclick="switchMode('create')">Create New</button>
            <button type="button" onclick="switchMode('update')">Update Record</button>
            <button type="button" onclick="switchMode('delete')">Delete Record</button>
        </div>
<%
    if ("select".equals(mode)) {
%>
        <h3>Select Record</h3>
        <p>
            <label for="stateId">Choose State ID (executes query on change):</label><br>
            <select id="stateId" name="stateId" onchange="handleDropdownChange()">
                <option value="">-- Select State ID --</option>
<%
        // Populate the dropdown with all state records, marking the active state as selected
        for (StateBean item : allStates) {
            String selectedAttr = (activeState.getStateId() == item.getStateId()) ? " selected" : "";
%>
                <option value="<%= item.getStateId() %>"<%= selectedAttr %>><%= item.getStateId() %> - <%= item.getStateName() %></option>
<%
        }
%>
            </select>
        </p>
<%
        // Display the selected state record in a table if a valid state ID is present
        if (activeState.getStateId() > 0) {
%>
        <table>
            <thead>
                <tr>
                    <th>State ID</th>
                    <th>State Name</th>
                    <th>Capital City</th>
                    <th>Region</th>
                    <th>Visitor Rating</th>
                    <th>Highlights</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= activeState.getStateId() %></td>
                    <td><%= activeState.getStateName() %></td>
                    <td><%= activeState.getCapitalCity() %></td>
                    <td><%= activeState.getRegion() %></td>
                    <td><%= activeState.getVisitorRating() %></td>
                    <td><%= activeState.getHighlights() %></td>
                </tr>
            </tbody>
        </table>
<%
        }
    } else if ("create".equals(mode)) {
        String createNameVal = "applyCreate".equals(effectiveAction) && activeState.getStateName() != null ? activeState.getStateName() : "";
        String createCapitalVal = "applyCreate".equals(effectiveAction) && activeState.getCapitalCity() != null ? activeState.getCapitalCity() : "";
        String createRegionVal = "applyCreate".equals(effectiveAction) && activeState.getRegion() != null ? activeState.getRegion() : "";
        String createRatingVal = "applyCreate".equals(effectiveAction) && activeState.getVisitorRating() > 0 ? String.valueOf(activeState.getVisitorRating()) : "";
        String createHighlightsVal = "applyCreate".equals(effectiveAction) && activeState.getHighlights() != null ? activeState.getHighlights() : "";
%>
        <h3>Create New Record</h3>
        <p>
            <label for="stateName">State Name:</label><br>
            <input type="text" id="stateName" name="stateName" value="<%= createNameVal %>">
        </p>
        <p>
            <label for="capitalCity">Capital City:</label><br>
            <input type="text" id="capitalCity" name="capitalCity" value="<%= createCapitalVal %>">
        </p>
        <p>
            <label for="region">Region:</label><br>
            <input type="text" id="region" name="region" value="<%= createRegionVal %>">
        </p>
        <p>
            <label for="visitorRating">Visitor Rating (0.0 to 5.0):</label><br>
            <input type="text" id="visitorRating" name="visitorRating" value="<%= createRatingVal %>">
        </p>
        <p>
            <label for="highlights">Highlights:</label><br>
            <input type="text" id="highlights" name="highlights" value="<%= createHighlightsVal %>">
        </p>
        <p>
            <button type="submit" name="submittedAction" value="applyCreate">Apply</button>
        </p>
<%
    }
%>
    </form>

    <h2>All Records in marco_states_data</h2>
    <table>
        <thead>
            <tr>
                <th>State ID</th>
                <th>State Name</th>
                <th>Capital City</th>
                <th>Region</th>
                <th>Visitor Rating</th>
                <th>Highlights</th>
            </tr>
        </thead>
        <tbody>
<%
    // Display all state records in the complete-records table
    for (StateBean row : allStates) {
%>
            <tr>
                <td><%= row.getStateId() %></td>
                <td><%= row.getStateName() %></td>
                <td><%= row.getCapitalCity() %></td>
                <td><%= row.getRegion() %></td>
                <td><%= row.getVisitorRating() %></td>
                <td><%= row.getHighlights() %></td>
            </tr>
<%
    }
%>
        </tbody>
    </table>
</body>
</html>