package com.states;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Data-access JavaBean for U.S. state records in
 * marco_states_data table.
 *
 * Marco Rodriguez
 * 2026-11-20
 */
public class StateBean implements Serializable {

    private static final long serialVersionUID = 1L;

    // Database connection settings configured outside JSP view markup
    private static final String DB_URL = "jdbc:mysql://localhost:3306/CSD430";
    private static final String DB_USER = "student1";
    private static final String DB_PASS = "pass";
    private static final String TABLE_NAME = "marco_states_data";

    private int stateId;
    private String stateName;
    private String capitalCity;
    private String region;
    private double visitorRating;
    private String highlights;

    /**
     * Creates an empty state bean.
     */
    public StateBean() {
    }

    /**
     * Creates a state bean populated with record values.
     *
     * @param stateId unique state record identifier
     * @param stateName official state name
     * @param capitalCity state capital city
     * @param region geographic region
     * @param visitorRating visitor rating from 0.0 through 5.0
     * @param highlights key attractions and features
     */
    public StateBean(int stateId, String stateName, String capitalCity, String region, double visitorRating, String highlights) {
        this.stateId = stateId;
        this.stateName = stateName;
        this.capitalCity = capitalCity;
        this.region = region;
        this.visitorRating = visitorRating;
        this.highlights = highlights;
    }

    public int getStateId() {
        return stateId;
    }

    public void setStateId(int stateId) {
        this.stateId = stateId;
    }

    public String getStateName() {
        return stateName;
    }

    public void setStateName(String stateName) {
        this.stateName = stateName;
    }

    public String getCapitalCity() {
        return capitalCity;
    }

    public void setCapitalCity(String capitalCity) {
        this.capitalCity = capitalCity;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public double getVisitorRating() {
        return visitorRating;
    }

    public void setVisitorRating(double visitorRating) {
        this.visitorRating = visitorRating;
    }

    public String getHighlights() {
        return highlights;
    }

    public void setHighlights(String highlights) {
        this.highlights = highlights;
    }

    /**
     * Opens a JDBC connection using the configured MySQL database settings.
     *
     * @return an open database connection
     * @throws ClassNotFoundException if the MySQL JDBC driver is unavailable
     * @throws SQLException if the connection cannot be opened
     */
    private Connection getConnection() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
    }

    /**
     * Retrieves all state records ordered by state ID.
     *
     * @return all records in {@code marco_states_data}
     * @throws ClassNotFoundException if the MySQL JDBC driver is unavailable
     * @throws SQLException if the query cannot be executed
     */
    public List<StateBean> getAllStates() throws ClassNotFoundException, SQLException {
        List<StateBean> list = new ArrayList<>();
        String sql = "SELECT state_id, state_name, capital_city, region, visitor_rating, highlights FROM "
                   + TABLE_NAME + " ORDER BY state_id ASC";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                StateBean row = new StateBean(
                    rs.getInt("state_id"),
                    rs.getString("state_name"),
                    rs.getString("capital_city"),
                    rs.getString("region"),
                    rs.getDouble("visitor_rating"),
                    rs.getString("highlights")
                );
                list.add(row);
            }
        }
        return list;
    }

    /**
     * Loads one state record matching the supplied primary key.
     *
     * @param id state record identifier
     * @return {@code true} if a matching record was loaded; otherwise {@code false}
     * @throws ClassNotFoundException if the MySQL JDBC driver is unavailable
     * @throws SQLException if the query cannot be executed
     */
    public boolean loadStateById(int id) throws ClassNotFoundException, SQLException {
        String sql = "SELECT state_id, state_name, capital_city, region, visitor_rating, highlights FROM "
                   + TABLE_NAME + " WHERE state_id = ?";

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    this.stateId = rs.getInt("state_id");
                    this.stateName = rs.getString("state_name");
                    this.capitalCity = rs.getString("capital_city");
                    this.region = rs.getString("region");
                    this.visitorRating = rs.getDouble("visitor_rating");
                    this.highlights = rs.getString("highlights");
                    return true;
                }
            }
        }
        return false;
    }

    /*
     * Inserts a new state record into the database using MySQL SET syntax and returns the generated primary key.
     * @return the generated primary key of the inserted state record
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public int insertState() throws ClassNotFoundException, SQLException {
        String sql = "INSERT INTO CSD430." + TABLE_NAME + " SET "
                + "state_name = ?, "
                + "capital_city = ?, "
                + "region = ?, "
                + "visitor_rating = ?, "
                + "highlights = ?";

        try (Connection conn = getConnection();
            PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, this.stateName);
            ps.setString(2, this.capitalCity);
            ps.setString(3, this.region);
            ps.setDouble(4, this.visitorRating);
            ps.setString(5, this.highlights);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet keys = ps.getGeneratedKeys()) {
                    if (keys.next()) {
                        this.stateId = keys.getInt(1);
                    }
                }
            }
        }
        return this.stateId;
    }


    /**
     * Creates marco_states_data if it does not already exist.
     *
     * @throws ClassNotFoundException if the MySQL JDBC driver is unavailable
     * @throws SQLException if the table cannot be created
     */
    public void createTable() throws ClassNotFoundException, SQLException {
        String sql = "CREATE TABLE IF NOT EXISTS " + TABLE_NAME + " ("
                   + "state_id INT AUTO_INCREMENT PRIMARY KEY, "
                   + "state_name VARCHAR(100) NOT NULL, "
                   + "capital_city VARCHAR(100) NOT NULL, "
                   + "region VARCHAR(50) NOT NULL, "
                   + "visitor_rating DECIMAL(2,1) NOT NULL, "
                   + "highlights VARCHAR(255) NOT NULL"
                   + ")";
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(sql);
        }
    }

    /**
     * Inserts the project’s initial state records into
     * marco_states_data
     *
     * @throws ClassNotFoundException if the MySQL JDBC driver is unavailable
     * @throws SQLException if the insert batch cannot be executed
     */
    public void populateTable() throws ClassNotFoundException, SQLException {
        String sql = "INSERT INTO " + TABLE_NAME
                   + " (state_name, capital_city, region, visitor_rating, highlights) VALUES (?, ?, ?, ?, ?)";
        Object[][] rows = {
            {"Texas", "Austin", "South Central", 4.8, "Live music, hill country trails, and vibrant food culture"},
            {"California", "Sacramento", "West Coast", 4.7, "Pacific coast highways, national parks, and diverse cities"},
            {"Colorado", "Denver", "Mountain West", 4.9, "Rocky Mountain peaks, outdoor adventure, and alpine towns"},
            {"New Mexico", "Santa Fe", "Southwest", 4.6, "Pueblo architecture, desert landscapes, and art galleries"},
            {"Arizona", "Phoenix", "Southwest", 4.7, "Red rock formations, desert canyons, and warm sunshine"},
            {"New York", "Albany", "Northeast", 4.6, "Hudson Valley scenery, historic towns, and major city landmarks"},
            {"Washington", "Olympia", "Pacific Northwest", 4.8, "Evergreen forests, Puget Sound ferries, and mountain views"},
            {"Florida", "Tallahassee", "Southeast", 4.5, "Coastal beaches, springs, and warm weather year round"},
            {"Utah", "Salt Lake City", "Mountain West", 4.9, "Scenic canyons, red rock arches, and mountain recreation"},
            {"Oregon", "Salem", "Pacific Northwest", 4.7, "Rugged coastline, waterfalls, and forested scenic routes"}
        };

        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (Object[] row : rows) {
                ps.setString(1, (String) row[0]);
                ps.setString(2, (String) row[1]);
                ps.setString(3, (String) row[2]);
                ps.setDouble(4, (Double) row[3]);
                ps.setString(5, (String) row[4]);
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }

    /**
     * Drops marco_states_data if it exists.
     *
     * @throws ClassNotFoundException if the MySQL JDBC driver is unavailable
     * @throws SQLException if the table cannot be dropped
     */
    public void dropTable() throws ClassNotFoundException, SQLException {
        String sql = "DROP TABLE IF EXISTS " + TABLE_NAME;
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement()) {
            stmt.executeUpdate(sql);
        }
    }
}