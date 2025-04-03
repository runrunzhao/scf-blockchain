const customTokenABI = [
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "spender",
                    "type": "address"
                },
                {
                    "internalType": "uint256",
                    "name": "value",
                    "type": "uint256"
                }
            ],
            "name": "approve",
            "outputs": [
                {
                    "internalType": "bool",
                    "name": "",
                    "type": "bool"
                }
            ],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "uint256",
                    "name": "amount",
                    "type": "uint256"
                }
            ],
            "name": "burn",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "account",
                    "type": "address"
                },
                {
                    "internalType": "uint256",
                    "name": "amount",
                    "type": "uint256"
                }
            ],
            "name": "burnFrom",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "string",
                    "name": "name",
                    "type": "string"
                },
                {
                    "internalType": "string",
                    "name": "symbol",
                    "type": "string"
                },
                {
                    "internalType": "uint256",
                    "name": "_expirationDate",
                    "type": "uint256"
                }
            ],
            "stateMutability": "nonpayable",
            "type": "constructor"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "spender",
                    "type": "address"
                },
                {
                    "internalType": "uint256",
                    "name": "allowance",
                    "type": "uint256"
                },
                {
                    "internalType": "uint256",
                    "name": "needed",
                    "type": "uint256"
                }
            ],
            "name": "ERC20InsufficientAllowance",
            "type": "error"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "sender",
                    "type": "address"
                },
                {
                    "internalType": "uint256",
                    "name": "balance",
                    "type": "uint256"
                },
                {
                    "internalType": "uint256",
                    "name": "needed",
                    "type": "uint256"
                }
            ],
            "name": "ERC20InsufficientBalance",
            "type": "error"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "approver",
                    "type": "address"
                }
            ],
            "name": "ERC20InvalidApprover",
            "type": "error"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "receiver",
                    "type": "address"
                }
            ],
            "name": "ERC20InvalidReceiver",
            "type": "error"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "sender",
                    "type": "address"
                }
            ],
            "name": "ERC20InvalidSender",
            "type": "error"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "spender",
                    "type": "address"
                }
            ],
            "name": "ERC20InvalidSpender",
            "type": "error"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "to",
                    "type": "address"
                },
                {
                    "internalType": "uint256",
                    "name": "amount",
                    "type": "uint256"
                }
            ],
            "name": "mint",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "owner",
                    "type": "address"
                }
            ],
            "name": "OwnableInvalidOwner",
            "type": "error"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "account",
                    "type": "address"
                }
            ],
            "name": "OwnableUnauthorizedAccount",
            "type": "error"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": true,
                    "internalType": "address",
                    "name": "owner",
                    "type": "address"
                },
                {
                    "indexed": true,
                    "internalType": "address",
                    "name": "spender",
                    "type": "address"
                },
                {
                    "indexed": false,
                    "internalType": "uint256",
                    "name": "value",
                    "type": "uint256"
                }
            ],
            "name": "Approval",
            "type": "event"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": true,
                    "internalType": "address",
                    "name": "previousOwner",
                    "type": "address"
                },
                {
                    "indexed": true,
                    "internalType": "address",
                    "name": "newOwner",
                    "type": "address"
                }
            ],
            "name": "OwnershipTransferred",
            "type": "event"
        },
        {
            "inputs": [],
            "name": "renounceOwnership",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "recipient",
                    "type": "address"
                },
                {
                    "internalType": "uint256",
                    "name": "amount",
                    "type": "uint256"
                }
            ],
            "name": "transfer",
            "outputs": [
                {
                    "internalType": "bool",
                    "name": "",
                    "type": "bool"
                }
            ],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "anonymous": false,
            "inputs": [
                {
                    "indexed": true,
                    "internalType": "address",
                    "name": "from",
                    "type": "address"
                },
                {
                    "indexed": true,
                    "internalType": "address",
                    "name": "to",
                    "type": "address"
                },
                {
                    "indexed": false,
                    "internalType": "uint256",
                    "name": "value",
                    "type": "uint256"
                }
            ],
            "name": "Transfer",
            "type": "event"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "sender",
                    "type": "address"
                },
                {
                    "internalType": "address",
                    "name": "recipient",
                    "type": "address"
                },
                {
                    "internalType": "uint256",
                    "name": "amount",
                    "type": "uint256"
                }
            ],
            "name": "transferFrom",
            "outputs": [
                {
                    "internalType": "bool",
                    "name": "",
                    "type": "bool"
                }
            ],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "newOwner",
                    "type": "address"
                }
            ],
            "name": "transferOwnership",
            "outputs": [],
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "owner",
                    "type": "address"
                },
                {
                    "internalType": "address",
                    "name": "spender",
                    "type": "address"
                }
            ],
            "name": "allowance",
            "outputs": [
                {
                    "internalType": "uint256",
                    "name": "",
                    "type": "uint256"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [
                {
                    "internalType": "address",
                    "name": "account",
                    "type": "address"
                }
            ],
            "name": "balanceOf",
            "outputs": [
                {
                    "internalType": "uint256",
                    "name": "",
                    "type": "uint256"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "decimals",
            "outputs": [
                {
                    "internalType": "uint8",
                    "name": "",
                    "type": "uint8"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "expirationDate",
            "outputs": [
                {
                    "internalType": "uint256",
                    "name": "",
                    "type": "uint256"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "getTimeInfo",
            "outputs": [
                {
                    "internalType": "uint256",
                    "name": "currentTime",
                    "type": "uint256"
                },
                {
                    "internalType": "uint256",
                    "name": "expiryTime",
                    "type": "uint256"
                },
                {
                    "internalType": "bool",
                    "name": "isExpired",
                    "type": "bool"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "name",
            "outputs": [
                {
                    "internalType": "string",
                    "name": "",
                    "type": "string"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "owner",
            "outputs": [
                {
                    "internalType": "address",
                    "name": "",
                    "type": "address"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "symbol",
            "outputs": [
                {
                    "internalType": "string",
                    "name": "",
                    "type": "string"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        },
        {
            "inputs": [],
            "name": "totalSupply",
            "outputs": [
                {
                    "internalType": "uint256",
                    "name": "",
                    "type": "uint256"
                }
            ],
            "stateMutability": "view",
            "type": "function"
        }
  
];  


const customTokenBytecode="608060405234801561000f575f80fd5b50604051611cf8380380611cf88339818101604052810190610031919061036a565b338383816003908161004391906105f6565b50806004908161005391906105f6565b5050505f73ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff16036100c6575f6040517f1e4fbdf70000000000000000000000000000000000000000000000000000000081526004016100bd9190610704565b60405180910390fd5b6100d58161012760201b60201c565b50428111610118576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161010f9061079d565b60405180910390fd5b806006819055505050506107bb565b5f60055f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690508160055f6101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508173ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff167f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e060405160405180910390a35050565b5f604051905090565b5f80fd5b5f80fd5b5f80fd5b5f80fd5b5f601f19601f8301169050919050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52604160045260245ffd5b61024982610203565b810181811067ffffffffffffffff8211171561026857610267610213565b5b80604052505050565b5f61027a6101ea565b90506102868282610240565b919050565b5f67ffffffffffffffff8211156102a5576102a4610213565b5b6102ae82610203565b9050602081019050919050565b8281835e5f83830152505050565b5f6102db6102d68461028b565b610271565b9050828152602081018484840111156102f7576102f66101ff565b5b6103028482856102bb565b509392505050565b5f82601f83011261031e5761031d6101fb565b5b815161032e8482602086016102c9565b91505092915050565b5f819050919050565b61034981610337565b8114610353575f80fd5b50565b5f8151905061036481610340565b92915050565b5f805f60608486031215610381576103806101f3565b5b5f84015167ffffffffffffffff81111561039e5761039d6101f7565b5b6103aa8682870161030a565b935050602084015167ffffffffffffffff8111156103cb576103ca6101f7565b5b6103d78682870161030a565b92505060406103e886828701610356565b9150509250925092565b5f81519050919050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52602260045260245ffd5b5f600282049050600182168061044057607f821691505b602082108103610453576104526103fc565b5b50919050565b5f819050815f5260205f209050919050565b5f6020601f8301049050919050565b5f82821b905092915050565b5f600883026104b57fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff8261047a565b6104bf868361047a565b95508019841693508086168417925050509392505050565b5f819050919050565b5f6104fa6104f56104f084610337565b6104d7565b610337565b9050919050565b5f819050919050565b610513836104e0565b61052761051f82610501565b848454610486565b825550505050565b5f90565b61053b61052f565b61054681848461050a565b505050565b5b818110156105695761055e5f82610533565b60018101905061054c565b5050565b601f8211156105ae5761057f81610459565b6105888461046b565b81016020851015610597578190505b6105ab6105a38561046b565b83018261054b565b50505b505050565b5f82821c905092915050565b5f6105ce5f19846008026105b3565b1980831691505092915050565b5f6105e683836105bf565b9150826002028217905092915050565b6105ff826103f2565b67ffffffffffffffff81111561061857610617610213565b5b6106228254610429565b61062d82828561056d565b5f60209050601f83116001811461065e575f841561064c578287015190505b61065685826105db565b8655506106bd565b601f19841661066c86610459565b5f5b828110156106935784890151825560018201915060208501945060208101905061066e565b868310156106b057848901516106ac601f8916826105bf565b8355505b6001600288020188555050505b505050505050565b5f73ffffffffffffffffffffffffffffffffffffffff82169050919050565b5f6106ee826106c5565b9050919050565b6106fe816106e4565b82525050565b5f6020820190506107175f8301846106f5565b92915050565b5f82825260208201905092915050565b7f45787069726174696f6e2064617465206d75737420626520696e2074686520665f8201527f7574757265000000000000000000000000000000000000000000000000000000602082015250565b5f61078760258361071d565b91506107928261072d565b604082019050919050565b5f6020820190508181035f8301526107b48161077b565b9050919050565b611530806107c85f395ff3fe608060405234801561000f575f80fd5b5060043610610109575f3560e01c806370a08231116100a05780638f6204871161006f5780638f6204871461029357806395d89b41146102b1578063a9059cbb146102cf578063dd62ed3e146102ff578063f2fde38b1461032f57610109565b806370a082311461021f578063715018a61461024f57806379cc6790146102595780638da5cb5b1461027557610109565b8063313ce567116100dc578063313ce567146101a957806340c10f19146101c757806342966c68146101e35780636fe8022c146101ff57610109565b806306fdde031461010d578063095ea7b31461012b57806318160ddd1461015b57806323b872dd14610179575b5f80fd5b61011561034b565b6040516101229190611053565b60405180910390f35b61014560048036038101906101409190611104565b6103db565b604051610152919061115c565b60405180910390f35b6101636103fd565b6040516101709190611184565b60405180910390f35b610193600480360381019061018e919061119d565b610406565b6040516101a0919061115c565b60405180910390f35b6101b1610460565b6040516101be9190611208565b60405180910390f35b6101e160048036038101906101dc9190611104565b610468565b005b6101fd60048036038101906101f89190611221565b6104c3565b005b6102076104d0565b6040516102169392919061124c565b60405180910390f35b61023960048036038101906102349190611281565b6104e7565b6040516102469190611184565b60405180910390f35b61025761052c565b005b610273600480360381019061026e9190611104565b61053f565b005b61027d6105ab565b60405161028a91906112bb565b60405180910390f35b61029b6105d3565b6040516102a89190611184565b60405180910390f35b6102b96105d9565b6040516102c69190611053565b60405180910390f35b6102e960048036038101906102e49190611104565b610669565b6040516102f6919061115c565b60405180910390f35b610319600480360381019061031491906112d4565b6106c1565b6040516103269190611184565b60405180910390f35b61034960048036038101906103449190611281565b610743565b005b60606003805461035a9061133f565b80601f01602080910402602001604051908101604052809291908181526020018280546103869061133f565b80156103d15780601f106103a8576101008083540402835291602001916103d1565b820191905f5260205f20905b8154815290600101906020018083116103b457829003601f168201915b5050505050905090565b5f806103e56107c7565b90506103f28185856107ce565b600191505092915050565b5f600254905090565b5f60065442111561044c576040517f08c379a0000000000000000000000000000000000000000000000000000000008152600401610443906113b9565b60405180910390fd5b6104578484846107e0565b90509392505050565b5f6012905090565b61047061080e565b6006544211156104b5576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016104ac906113b9565b60405180910390fd5b6104bf8282610895565b5050565b6104cd3382610914565b50565b5f805f429250600654915060065442119050909192565b5f805f8373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f20549050919050565b61053461080e565b61053d5f610993565b565b5f61054a83336106c1565b90508181101561058f576040517f08c379a000000000000000000000000000000000000000000000000000000000815260040161058690611447565b60405180910390fd5b61059c83338484036107ce565b6105a68383610914565b505050565b5f60055f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff16905090565b60065481565b6060600480546105e89061133f565b80601f01602080910402602001604051908101604052809291908181526020018280546106149061133f565b801561065f5780601f106106365761010080835404028352916020019161065f565b820191905f5260205f20905b81548152906001019060200180831161064257829003601f168201915b5050505050905090565b5f6006544211156106af576040517f08c379a00000000000000000000000000000000000000000000000000000000081526004016106a6906113b9565b60405180910390fd5b6106b98383610a56565b905092915050565b5f60015f8473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f8373ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f2054905092915050565b61074b61080e565b5f73ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff16036107bb575f6040517f1e4fbdf70000000000000000000000000000000000000000000000000000000081526004016107b291906112bb565b60405180910390fd5b6107c481610993565b50565b5f33905090565b6107db8383836001610a78565b505050565b5f806107ea6107c7565b90506107f7858285610c47565b610802858585610cda565b60019150509392505050565b6108166107c7565b73ffffffffffffffffffffffffffffffffffffffff166108346105ab565b73ffffffffffffffffffffffffffffffffffffffff1614610893576108576107c7565b6040517f118cdaa700000000000000000000000000000000000000000000000000000000815260040161088a91906112bb565b60405180910390fd5b565b5f73ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff1603610905575f6040517fec442f050000000000000000000000000000000000000000000000000000000081526004016108fc91906112bb565b60405180910390fd5b6109105f8383610dca565b5050565b5f73ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff1603610984575f6040517f96c6fd1e00000000000000000000000000000000000000000000000000000000815260040161097b91906112bb565b60405180910390fd5b61098f825f83610dca565b5050565b5f60055f9054906101000a900473ffffffffffffffffffffffffffffffffffffffff1690508160055f6101000a81548173ffffffffffffffffffffffffffffffffffffffff021916908373ffffffffffffffffffffffffffffffffffffffff1602179055508173ffffffffffffffffffffffffffffffffffffffff168173ffffffffffffffffffffffffffffffffffffffff167f8be0079c531659141344cd1fd0a4f28419497f9722a3daafe3b4186f6b6457e060405160405180910390a35050565b5f80610a606107c7565b9050610a6d818585610cda565b600191505092915050565b5f73ffffffffffffffffffffffffffffffffffffffff168473ffffffffffffffffffffffffffffffffffffffff1603610ae8575f6040517fe602df05000000000000000000000000000000000000000000000000000000008152600401610adf91906112bb565b60405180910390fd5b5f73ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff1603610b58575f6040517f94280d62000000000000000000000000000000000000000000000000000000008152600401610b4f91906112bb565b60405180910390fd5b8160015f8673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f8573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f20819055508015610c41578273ffffffffffffffffffffffffffffffffffffffff168473ffffffffffffffffffffffffffffffffffffffff167f8c5be1e5ebec7d5bd14f71427d1e84f3dd0314c0f7b2291e5b200ac8c7c3b92584604051610c389190611184565b60405180910390a35b50505050565b5f610c5284846106c1565b90507fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff811015610cd45781811015610cc5578281836040517ffb8f41b2000000000000000000000000000000000000000000000000000000008152600401610cbc93929190611465565b60405180910390fd5b610cd384848484035f610a78565b5b50505050565b5f73ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff1603610d4a575f6040517f96c6fd1e000000000000000000000000000000000000000000000000000000008152600401610d4191906112bb565b60405180910390fd5b5f73ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff1603610dba575f6040517fec442f05000000000000000000000000000000000000000000000000000000008152600401610db191906112bb565b60405180910390fd5b610dc5838383610dca565b505050565b5f73ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff1603610e1a578060025f828254610e0e91906114c7565b92505081905550610ee8565b5f805f8573ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f2054905081811015610ea3578381836040517fe450d38c000000000000000000000000000000000000000000000000000000008152600401610e9a93929190611465565b60405180910390fd5b8181035f808673ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f2081905550505b5f73ffffffffffffffffffffffffffffffffffffffff168273ffffffffffffffffffffffffffffffffffffffff1603610f2f578060025f8282540392505081905550610f79565b805f808473ffffffffffffffffffffffffffffffffffffffff1673ffffffffffffffffffffffffffffffffffffffff1681526020019081526020015f205f82825401925050819055505b8173ffffffffffffffffffffffffffffffffffffffff168373ffffffffffffffffffffffffffffffffffffffff167fddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef83604051610fd69190611184565b60405180910390a3505050565b5f81519050919050565b5f82825260208201905092915050565b8281835e5f83830152505050565b5f601f19601f8301169050919050565b5f61102582610fe3565b61102f8185610fed565b935061103f818560208601610ffd565b6110488161100b565b840191505092915050565b5f6020820190508181035f83015261106b818461101b565b905092915050565b5f80fd5b5f73ffffffffffffffffffffffffffffffffffffffff82169050919050565b5f6110a082611077565b9050919050565b6110b081611096565b81146110ba575f80fd5b50565b5f813590506110cb816110a7565b92915050565b5f819050919050565b6110e3816110d1565b81146110ed575f80fd5b50565b5f813590506110fe816110da565b92915050565b5f806040838503121561111a57611119611073565b5b5f611127858286016110bd565b9250506020611138858286016110f0565b9150509250929050565b5f8115159050919050565b61115681611142565b82525050565b5f60208201905061116f5f83018461114d565b92915050565b61117e816110d1565b82525050565b5f6020820190506111975f830184611175565b92915050565b5f805f606084860312156111b4576111b3611073565b5b5f6111c1868287016110bd565b93505060206111d2868287016110bd565b92505060406111e3868287016110f0565b9150509250925092565b5f60ff82169050919050565b611202816111ed565b82525050565b5f60208201905061121b5f8301846111f9565b92915050565b5f6020828403121561123657611235611073565b5b5f611243848285016110f0565b91505092915050565b5f60608201905061125f5f830186611175565b61126c6020830185611175565b611279604083018461114d565b949350505050565b5f6020828403121561129657611295611073565b5b5f6112a3848285016110bd565b91505092915050565b6112b581611096565b82525050565b5f6020820190506112ce5f8301846112ac565b92915050565b5f80604083850312156112ea576112e9611073565b5b5f6112f7858286016110bd565b9250506020611308858286016110bd565b9150509250929050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52602260045260245ffd5b5f600282049050600182168061135657607f821691505b60208210810361136957611368611312565b5b50919050565b7f546f6b656e2068617320657870697265640000000000000000000000000000005f82015250565b5f6113a3601183610fed565b91506113ae8261136f565b602082019050919050565b5f6020820190508181035f8301526113d081611397565b9050919050565b7f45524332303a206275726e20616d6f756e74206578636565647320616c6c6f775f8201527f616e636500000000000000000000000000000000000000000000000000000000602082015250565b5f611431602483610fed565b915061143c826113d7565b604082019050919050565b5f6020820190508181035f83015261145e81611425565b9050919050565b5f6060820190506114785f8301866112ac565b6114856020830185611175565b6114926040830184611175565b949350505050565b7f4e487b71000000000000000000000000000000000000000000000000000000005f52601160045260245ffd5b5f6114d1826110d1565b91506114dc836110d1565b92508282019050808211156114f4576114f361149a565b5b9291505056fea264697066735822122061079bf18d7576858706cc3605756c8feb5ffe40fafc3876adf256b96f7054a964736f6c634300081a0033" ;

// 已部署的 CustomToken 合约地址
const customTokenAddress = "0x05DbB0a29f9d80b3a3CE4132efA898cabd05113b";

// =========================================================
// TokenFactory 合约的 ABI - 用于部署新的 CustomToken 合约
// =========================================================
const tokenFactoryABI = [
    // ⬇️⬇️⬇️ PASTE YOUR TOKEN FACTORY ABI FROM REMIX HERE ⬇️⬇️⬇️
    // Make sure to remove any outer brackets that Remix might include
    {
        "inputs": [
            {"name": "name", "type": "string"},
            {"name": "symbol", "type": "string"},
            {"name": "expirationDate", "type": "uint256"}
        ],
        "name": "deployCustomToken",
        "outputs": [{"name": "newToken", "type": "address"}],
        "stateMutability": "nonpayable",
        "type": "function"
    }
    
]; 

// TokenFactory 合约地址
const tokenFactoryAddress = "0xYourTokenFactoryAddress"; // 替换为你的 TokenFactory 合约地址

// =========================================================
// 导出以便其他文件使用
// =========================================================
if (typeof module !== 'undefined' && module.exports) {
    module.exports = { 
        customTokenABI, 
        customTokenAddress,
        tokenFactoryABI,
        tokenFactoryAddress
    };
}