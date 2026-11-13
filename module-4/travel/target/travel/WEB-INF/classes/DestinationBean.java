package com.javabean;
import java.io.Serializable;

// The JavaBean must implement java.io.Serializable per the requirements
public class DestinationBean implements Serializable {
    
    // A standard serial version UID for serializable classes
    private static final long serialVersionUID = 1L;
    
    // Five private fields to hold the data
    private String destinationName;
    private String region;
    private String category;
    private double rating;
    private String description;
    
    // A standard no-argument constructor required for JavaBeans
    public DestinationBean() {
    }
    
    // A parameterized constructor to make populating the data easier
    public DestinationBean(String destinationName, String region, String category, double rating, String description) {
        this.destinationName = destinationName;
        this.region = region;
        this.category = category;
        this.rating = rating;
        this.description = description;
    }

    // Public getter and setter methods for all fields
    public String getDestinationName() {
        return destinationName;
    }

    public void setDestinationName(String destinationName) {
        this.destinationName = destinationName;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}