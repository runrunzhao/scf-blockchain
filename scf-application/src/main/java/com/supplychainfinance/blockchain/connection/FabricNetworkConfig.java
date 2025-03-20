package com.supplychainfinance.blockchain.connection;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Properties;
import java.util.logging.Logger;

/**
 * Configuration loader for Fabric network connection
 */
public class FabricNetworkConfig {
    private static final Logger logger = Logger.getLogger(FabricNetworkConfig.class.getName());
    private static final String CONFIG_FILE = "/blockchain-config.properties";
    
    private static Properties properties = null;
    
    // Load configuration once when class is loaded
    static {
        loadConfig();
    }
    
    /**
     * Load configuration from properties file
     */
    private static void loadConfig() {
        properties = new Properties();
        
        try (InputStream input = FabricNetworkConfig.class.getResourceAsStream(CONFIG_FILE)) {
            if (input == null) {
                logger.severe("Unable to find " + CONFIG_FILE);
                throw new IOException("Config file not found");
            }
            
            properties.load(input);
            logger.info("Fabric network configuration loaded successfully");
        } catch (IOException e) {
            logger.severe("Error loading Fabric network configuration: " + e.getMessage());
            // Use default values as fallback
            setDefaults();
        }
    }
    
    /**
     * Set default configuration values
     */
    private static void setDefaults() {
        properties = new Properties();
        
        // Network configuration
        properties.setProperty("network.config.path", "/home/fabric/fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/connection-org1.json");
        properties.setProperty("channel.name", "mychannel");
        
        // Organization details
        properties.setProperty("org.mspid", "Org1MSP");
        
        // Admin credentials
        properties.setProperty("admin.cert.path", "/home/fabric/fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/signcerts/cert.pem");
        properties.setProperty("admin.key.path", "/home/fabric/fabric-samples/test-network/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/keystore/priv_sk");
        properties.setProperty("user.name", "admin");
        
        // Chaincode names
        properties.setProperty("ctt.chaincode.name", "cttTokenChaincode");
        properties.setProperty("invoice.chaincode.name", "invoiceProcessorChaincode");
        
        logger.info("Using default Fabric network configuration");
    }
    
    /**
     * Get configuration property
     */
    public static String getProperty(String key) {
        return properties.getProperty(key);
    }
    
    // Convenience methods for common configuration properties
    
    public static String getNetworkConfigPath() {
        return getProperty("network.config.path");
    }
    
    public static String getChannelName() {
        return getProperty("channel.name");
    }
    
    public static String getOrgMspId() {
        return getProperty("org.mspid");
    }
    
    public static String getAdminCertPath() {
        return getProperty("admin.cert.path");
    }
    
    public static String getAdminKeyPath() {
        return getProperty("admin.key.path");
    }
    
    public static String getUserName() {
        return getProperty("user.name");
    }
    
    public static String getCTTChaincodeName() {
        return getProperty("ctt.chaincode.name");
    }
    
    public static String getInvoiceChaincodeName() {
        return getProperty("invoice.chaincode.name");
    }
    
    /**
     * Check if config file exists and paths are valid
     */
    public static boolean validateConfiguration() {
        try {
            // Check if connection profile exists
            Path networkConfigPath = Paths.get(getNetworkConfigPath());
            if (!Files.exists(networkConfigPath)) {
                logger.severe("Network connection profile not found: " + getNetworkConfigPath());
                return false;
            }
            
            // Check if admin certificate exists
            Path adminCertPath = Paths.get(getAdminCertPath());
            if (!Files.exists(adminCertPath)) {
                logger.severe("Admin certificate not found: " + getAdminCertPath());
                return false;
            }
            
            // Check if admin private key exists
            Path adminKeyPath = Paths.get(getAdminKeyPath());
            if (!Files.exists(adminKeyPath)) {
                logger.severe("Admin private key not found: " + getAdminKeyPath());
                return false;
            }
            
            return true;
        } catch (Exception e) {
            logger.severe("Error validating configuration: " + e.getMessage());
            return false;
        }
    }
}