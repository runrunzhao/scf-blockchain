package com.supplychainfinance.blockchain.connection;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.concurrent.TimeUnit;
import java.util.logging.Logger;

import org.hyperledger.fabric.gateway.Contract;
import org.hyperledger.fabric.gateway.Gateway;
import org.hyperledger.fabric.gateway.Network;
import org.hyperledger.fabric.gateway.Wallet;
import org.hyperledger.fabric.gateway.Wallets;
import org.hyperledger.fabric.gateway.Identities;
import org.hyperledger.fabric.gateway.X509Identity;

/**
 * Manages connections to the Fabric network using the Gateway SDK
 */
public class FabricGatewayManager {
    private static final Logger logger = Logger.getLogger(FabricGatewayManager.class.getName());
    
    // Singleton instance
    private static FabricGatewayManager instance = null;
    
    private Gateway gateway = null;
    private Network network = null;
    
    /**
     * Get singleton instance
     */
    public static synchronized FabricGatewayManager getInstance() {
        if (instance == null) {
            instance = new FabricGatewayManager();
        }
        return instance;
    }
    
    /**
     * Private constructor for singleton pattern
     */
    private FabricGatewayManager() {
        // No initialization here - connection is established on demand
    }
    
    /**
     * Connect to the Fabric network
     */
    public synchronized void connect() throws IOException {
        if (gateway != null) {
            logger.info("Gateway connection already established");
            return;
        }
        
        logger.info("Connecting to Fabric network...");
        
        try {
            // Check configuration
            if (!FabricNetworkConfig.validateConfiguration()) {
                throw new IOException("Invalid Fabric network configuration");
            }
            
            // Load connection profile
            Path networkConfigPath = Paths.get(FabricNetworkConfig.getNetworkConfigPath());
            
            // Load a wallet with admin identity
            Wallet wallet = setupWallet();
            String userName = FabricNetworkConfig.getUserName();
            
            // Configure gateway connection
            Gateway.Builder builder = Gateway.createBuilder()
                    .identity(wallet, userName)
                    .networkConfig(networkConfigPath)
                    .discovery(true)
                    .commitTimeout(60, TimeUnit.SECONDS);
            
            // Create gateway connection
            gateway = builder.connect();
            logger.info("Gateway connection established");
            
            // Access channel
            network = gateway.getNetwork(FabricNetworkConfig.getChannelName());
            logger.info("Connected to channel: " + FabricNetworkConfig.getChannelName());
            
        } catch (IOException e) {
            logger.severe("Failed to connect to Fabric network: " + e.getMessage());
            
            // Clean up any partial connections
            if (gateway != null) {
                gateway.close();
                gateway = null;
                network = null;
            }
            
            throw e;
        }
    }
    
    /**
     * Setup wallet with admin identity
     */
    private Wallet setupWallet() throws IOException {
        try {
            // Create a wallet for managing identities
            Path walletPath = Paths.get(System.getProperty("java.io.tmpdir"), "fabric-wallet");
            Wallet wallet = Wallets.newFileSystemWallet(walletPath);
            
            // Check if admin identity already exists in wallet
            String userName = FabricNetworkConfig.getUserName();
            if (wallet.get(userName) != null) {
                logger.info("An identity for the user " + userName + " already exists in the wallet");
                return wallet;
            }
            
            // Load admin certificate
            Path certPath = Paths.get(FabricNetworkConfig.getAdminCertPath());
            Path keyPath = Paths.get(FabricNetworkConfig.getAdminKeyPath());
            
            // Load certificate and private key
            X509Identity adminIdentity = Identities.newX509Identity(
                FabricNetworkConfig.getOrgMspId(),
                Identities.readX509Certificate(Files.newBufferedReader(certPath)),
                Identities.readPrivateKey(Files.newBufferedReader(keyPath))
            );
            
            // Put admin identity into wallet
            wallet.put(userName, adminIdentity);
            logger.info("Successfully imported admin identity into the wallet");
            
            return wallet;
        } catch (Exception e) {
            logger.severe("Error setting up wallet: " + e.getMessage());
            throw new IOException("Failed to setup wallet", e);
        }
    }
    
    /**
     * Disconnect from the Fabric network
     */
    public synchronized void disconnect() {
        if (gateway != null) {
            gateway.close();
            gateway = null;
            network = null;
            logger.info("Gateway connection closed");
        }
    }
    
    /**
     * Get contract from the network
     */
    public synchronized Contract getContract(String chaincodeName) throws IOException {
        if (gateway == null || network == null) {
            connect();
        }
        
        logger.info("Getting contract: " + chaincodeName);
        return network.getContract(chaincodeName);
    }
    
    /**
     * Get CTT token contract
     */
    public Contract getCTTTokenContract() throws IOException {
        return getContract(FabricNetworkConfig.getCTTChaincodeName());
    }
    
    /**
     * Get invoice processor contract
     */
    public Contract getInvoiceProcessorContract() throws IOException {
        return getContract(FabricNetworkConfig.getInvoiceChaincodeName());
    }
}