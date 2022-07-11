import 'dart:convert';

import 'package:dart_web3/contracts.dart';
import 'package:dart_web3/credentials.dart';

import 'eth_client.dart';


class SushiGW {
  final DeployedContract gw;
  final EthClient client;
  final String address;

  Future swap(String addressIn, String addressOut) async {
    return await client.sendNewTransaction(gw, gw.function('swap'), [
      EthereumAddress.fromHex(
        addressIn,
      ),
      EthereumAddress.fromHex(
        addressOut,
      ),
      BigInt.from(60),
      BigInt.from(30),
      EthereumAddress.fromHex(
        address,
      ),

    ]);
  }

  factory SushiGW(String address, EthClient client) => SushiGW._(
    address,
    client,
    DeployedContract(ContractAbi.fromJson(jsonAbi, "TestSushi"),
        EthereumAddress.fromHex(address)),
  );

  SushiGW._(this.address, this.client, this.gw);
}

final jsonAbi = jsonEncode( [
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "_tokenIn",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "_tokenOut",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "_amountIn",
        "type": "uint256"
      },
      {
        "internalType": "uint256",
        "name": "_amountOutMin",
        "type": "uint256"
      },
      {
        "internalType": "address",
        "name": "_to",
        "type": "address"
      }
    ],
    "name": "swap",
    "outputs": [],
    "stateMutability": "payable",
    "type": "function"
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "_tokenIn",
        "type": "address"
      },
      {
        "internalType": "address",
        "name": "_tokenOut",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "_amountIn",
        "type": "uint256"
      }
    ],
    "name": "getAmountOutMin",
    "outputs": [
      {
        "internalType": "uint256",
        "name": "",
        "type": "uint256"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
  }
]);