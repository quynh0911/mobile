import 'dart:convert';
import 'package:dart_web3/dart_web3.dart';
import 'eth_client.dart';

class UniswapGW {
  final DeployedContract gw;
  final EthClient client;
  final String address;

  Future getAmountOut(
      String addressIn, String addressOut, BigInt amountIn) async {
    return (await client.call(
      gw,
      gw.function('getAmountOutMin'),
      [
        EthereumAddress.fromHex(addressIn),
        EthereumAddress.fromHex(addressOut),
        amountIn
      ],
    ))
        .first as BigInt;
  }

  Future swap(String addressIn, String addressOut, BigInt amountIn,
      String addressTo) async {
    await client.sendNewTransaction(
      gw, gw.function('swap'), [
      EthereumAddress.fromHex(
        addressIn,
      ),
      EthereumAddress.fromHex(
        addressOut,
      ),
      amountIn,

      EthereumAddress.fromHex(
        addressTo,
      ),
    ],
    );
    //   client.credentials,
    //   Transaction.callContract(
    //       contract: gw,
    //       function: gw.function('swap'),
    //       parameters: [
    //         EthereumAddress.fromHex(
    //           addressIn,
    //         ),
    //         EthereumAddress.fromHex(
    //           addressOut,
    //         ),
    //         amountIn,
    //         amountOut,
    //         EthereumAddress.fromHex(address),
    //       ],
    //       from: EthereumAddress.fromHex(addressTo)),
    //   chainId: 31337,
    // );
  }

  Future swapFromETHToToken(
      String addressOut, BigInt amountIn, BigInt amountInTest) async {
    await client.sendNewTransaction(
        gw,
        gw.function('swapFromETHToToken'),
        [
          EthereumAddress.fromHex(
            addressOut
          ),
          amountInTest
          // amountOut,
          // EthereumAddress.fromHex(
          //   addressTo
          // ),
        ],
        amountIn: amountIn
        // client.credentials,
        // Transaction.callContract(
        //     contract: gw,
        //     function: gw.function('swapFromETHToToken'),
        //     value: EtherAmount.inWei(amountIn),
        //     // from: EthereumAddress.fromHex(address),
        //     parameters: [
        //       EthereumAddress.fromHex(
        //         addressOut,
        //       ),
        //       amountOut,
        //       EthereumAddress.fromHex(
        //         address,
        //       ),
        //     ]),
        // chainId: 999
        );
  }

  Future swapFromTokenToETH(
      String addressIn, BigInt amountIn) async {
    await client.sendNewTransaction(
        gw,
        gw.function('swapFromTokenToETH'),
        [
          EthereumAddress.fromHex(
              addressIn
          ),
          amountIn,
          // amountOutMin,
          // EthereumAddress.fromHex(
          //     addressTo
          // ),
        ],
        // amountIn: amountIn
      // client.credentials,
      // Transaction.callContract(
      //     contract: gw,
      //     function: gw.function('swapFromETHToToken'),
      //     value: EtherAmount.inWei(amountIn),
      //     // from: EthereumAddress.fromHex(address),
      //     parameters: [
      //       EthereumAddress.fromHex(
      //         addressOut,
      //       ),
      //       amountOut,
      //       EthereumAddress.fromHex(
      //         address,
      //       ),
      //     ]),
      // chainId: 999
    );
  }

  factory UniswapGW(String address, EthClient client) => UniswapGW._(
        address,
        client,
        DeployedContract(ContractAbi.fromJson(abi, "TestUniswap"),
            EthereumAddress.fromHex(address)),
      );

  UniswapGW._(this.address, this.client, this.gw);
}

final abi = jsonEncode([
  {
    "inputs": [],
    "stateMutability": "payable",
    "type": "constructor",
    "payable": true
  },
  {
    "inputs": [],
    "name": "uniswapRouter",
    "outputs": [
      {
        "internalType": "contract IUniswapV2Router02",
        "name": "",
        "type": "address"
      }
    ],
    "stateMutability": "view",
    "type": "function",
    "constant": true
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
      },
      {
        "internalType": "address",
        "name": "_to",
        "type": "address"
      }
    ],
    "name": "swap",
    "outputs": [],
    "stateMutability": "nonpayable",
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
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "tokenOut",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "amountIn",
        "type": "uint256"
      }
    ],
    "name": "swapFromETHToToken",
    "outputs": [],
    "stateMutability": "payable",
    "type": "function",
    "payable": true
  },
  {
    "inputs": [
      {
        "internalType": "address",
        "name": "tokenIn",
        "type": "address"
      },
      {
        "internalType": "uint256",
        "name": "amountIn",
        "type": "uint256"
      }
    ],
    "name": "swapFromTokenToETH",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  }
]);
