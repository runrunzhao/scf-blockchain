package com.supplychainfinance.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class DBTest {
    public static void main(String[] args) {
        System.out.println("Testing database connection...");
        
        try (Connection conn = DBUtil.getConnection()) {
            System.out.println("Connection successful!");
            
            // Test database by checking if we can execute a query
            try (Statement stmt = conn.createStatement()) {
                // Try to query for database version
                System.out.println("Testing SQL query...");
                ResultSet rs = stmt.executeQuery("SELECT version()");
                
                if (rs.next()) {
                    System.out.println("Database version: " + rs.getString(1));
                }
                
                // List all tables in the database
                System.out.println("\nListing all tables in the database:");
                ResultSet tables = conn.getMetaData().getTables(conn.getCatalog(), null, "%", new String[]{"TABLE"});
                boolean hasTables = false;
                
                while (tables.next()) {
                    hasTables = true;
                    String tableName = tables.getString("TABLE_NAME");
                    System.out.println("- " + tableName);
                }
                
                if (!hasTables) {
                    System.out.println("No tables found in the database.");
                    System.out.println("You may need to create the required tables for your application.");
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Database connection failed!");
            System.err.println("Error: " + e.getMessage());
            System.err.println("SQLState: " + e.getSQLState());
            System.err.println("Error Code: " + e.getErrorCode());
            
            // Check for common connection issues and provide helpful messages
            if (e.getMessage().contains("Communications link failure")) {
                System.err.println("\nPOSSIBLE SOLUTION: Make sure your MySQL server is running.");
                System.err.println("If you're using Docker, check if your MySQL container is up with 'docker ps'");
            } else if (e.getMessage().contains("Access denied")) {
                System.err.println("\nPOSSIBLE SOLUTION: Check your username and password in database.properties");
            } else if (e.getMessage().contains("Unknown database")) {
                System.err.println("\nPOSSIBLE SOLUTION: The database does not exist. Create it first with:");
                System.err.println("CREATE DATABASE SCFDB;");
            }
        }
    }
}