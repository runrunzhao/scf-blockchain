package com.supplychainfinance.dao;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * 数据库连接管理器，负责创建和管理数据库连接
 * 使用 database.properties 文件中的配置信息
 */
public class DBConnectionManager {

    private static final String PROPERTIES_FILE = "/database.properties";
    private static String JDBC_DRIVER;
    private static String DB_URL;
    private static String USER;
    private static String PASS;
    
    // 静态初始化块，加载配置
    static {
        try {
            loadProperties();
        } catch (IOException e) {
            System.err.println("Error loading database properties: " + e.getMessage());
            e.printStackTrace();
        }
    }

    /**
     * 从配置文件加载数据库连接属性
     */
    private static void loadProperties() throws IOException {
        Properties props = new Properties();
        try (InputStream input = DBConnectionManager.class.getResourceAsStream(PROPERTIES_FILE)) {
            if (input == null) {
                throw new IOException("Unable to find " + PROPERTIES_FILE);
            }
            props.load(input);
            
            JDBC_DRIVER = props.getProperty("db.driver");
            DB_URL = props.getProperty("db.url");
            USER = props.getProperty("db.username");
            PASS = props.getProperty("db.password");
            
            System.out.println("Database properties loaded successfully");
        }
    }

    /**
     * 获取数据库连接
     * 
     * @return 数据库连接对象
     * @throws SQLException 如果获取连接失败
     */
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName(JDBC_DRIVER);
            return DriverManager.getConnection(DB_URL, USER, PASS);
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC Driver not found: " + JDBC_DRIVER, e);
        }
    }
}