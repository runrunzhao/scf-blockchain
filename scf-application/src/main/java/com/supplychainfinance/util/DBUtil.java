package com.supplychainfinance.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.io.IOException;
import java.io.InputStream;

public class DBUtil {
    private static Properties properties = new Properties();
    
    static {
        try (InputStream is = DBUtil.class.getClassLoader().getResourceAsStream("database.properties")) {
            if (is != null) {
                properties.load(is);
            } else {
                throw new RuntimeException("Unable to find database.properties");
            }
            
            // Load the JDBC driver
            Class.forName(properties.getProperty("db.driver"));
        } catch (IOException | ClassNotFoundException e) {
            throw new RuntimeException("Database configuration error", e);
        }
    }
    
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
            properties.getProperty("db.url"),
            properties.getProperty("db.username"),
            properties.getProperty("db.password")
        );
    }
}