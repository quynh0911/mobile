import 'package:blockchain_project/blockchain/gateways/uniswap.dart';
import 'package:flutter/foundation.dart';

import '../blockchain/contracts/ierc20.dart';
import '../blockchain/gateways/eth_client.dart';
import '../contanst/address.dart';

class WalletProvider extends ChangeNotifier {
  late EthClient client;
  late UniswapGW uniswapGW;
  late BigInt ethBalance;
  late BigInt daiBalance;
  late BigInt busdBalance;
  late BigInt usdcBalance;
  bool isLoading = true;
  String firstCoin = 'Ethereum';
  String secondCoin = 'DAI';
  late BigInt firstBalance;
  late BigInt secondBalance;
  late IERC20 weth;
  late IERC20 dai ;
  late IERC20 usdc;
  late IERC20 busd;

  void getClient() async {
    client = EthClient(Address.PRIVATE_KEY, Address.RPC_URL);
    weth = IERC20(Address.WETH, client);
    dai = IERC20(Address.DAI, client);
    usdc = IERC20(Address.USDC, client);
    busd = IERC20(Address.BUSD, client);
    final eth = await client.getBalance();
    uniswapGW = UniswapGW(Address.Uniswap, client);
    ethBalance = eth.getInEther;
    firstBalance = ethBalance;
    // daiBalance = BigInt.from(10000000);
    daiBalance = await dai.checkBalance();
    secondBalance = daiBalance;
    // usdcBalance = BigInt.from(10000000);
    usdcBalance = await usdc.checkBalance();
    busdBalance = await busd.checkBalance();
    isLoading = false;
    notifyListeners();
  }

  swapETHToToken(BigInt amountIn, String addressOut) async {

    final amountOutIn = BigInt.from(1);
    // client = EthClient(Address.PRIVATE_KEY, Address.RPC_URL);
    // uniswapGW = UniswapGW(Address.Uniswap, client);
    final test = await uniswapGW.swapFromETHToToken(
        addressOut, amountIn, amountOutIn, Address.address);
    final eth = await client.getBalance();
    ethBalance = eth.getInEther;
    daiBalance = await dai.checkBalance();
    usdcBalance = await usdc.checkBalance();
    busdBalance = await busd.checkBalance();
    notifyListeners();
  }

  swapTokenToToken(BigInt amountIn,String addressIn, String addressOut) async {
    final amountOutIn = BigInt.from(1);
    // var amountOutIn = await uniswapGW.getAmountOut(
    //     Address.WETH,
    //     Address.DAI,
    //     BigInt.from(10)
    // );
    // client = EthClient(Address.PRIVATE_KEY, Address.RPC_URL);
    // uniswapGW = UniswapGW(Address.Uniswap, client);
    switch(addressIn){
      case Address.DAI:
        await dai.approve(uniswapGW.address, amountIn);
        break;
      case Address.USDC:
        await usdc.approve(uniswapGW.address, amountIn);
        break;
      case Address.BUSD:
        await busd.approve(uniswapGW.address, amountIn);
        break;
    }
    await Future.delayed(const Duration(seconds: 3));
    final test = await uniswapGW.swap(
        addressIn, addressOut, amountIn, amountOutIn, Address.address);
    await Future.delayed(const Duration(seconds: 3));
    final eth = await client.getBalance();
    ethBalance = eth.getInEther;
    daiBalance = await dai.checkBalance();
    usdcBalance = await usdc.checkBalance();
    notifyListeners();
  }

  swapTokenToETH(BigInt amountIn, String addressIn) async {
    final amountOutIn = BigInt.from(0);
    // client = EthClient(Address.PRIVATE_KEY, Address.RPC_URL);
    // uniswapGW = UniswapGW(Address.Uniswap, client);
    switch(addressIn){
      case Address.DAI:
        await dai.approve(uniswapGW.address, amountIn);
        break;
      case Address.USDC:
        await usdc.approve(uniswapGW.address, amountIn);
        break;
      case Address.BUSD:
        await busd.approve(uniswapGW.address, amountIn);
        break;
    }
    await Future.delayed(Duration(seconds: 3));
    try {
      final test = await uniswapGW.swapFromTokenToETH(
          addressIn, amountIn, amountOutIn, Address.address);
    } catch (e){
      isLoading
      = false;
    }
    final eth = await client.getBalance();
    ethBalance = eth.getInEther;
    daiBalance = await dai.checkBalance();
    usdcBalance = await usdc.checkBalance();
    notifyListeners();
  }

  setFirstBalance(String newBitcoin) {
    firstCoin = newBitcoin;
    notifyListeners();
  }
  setLoading(bool state){
    isLoading = state;
    notifyListeners();
  }

  WalletProvider() {
    getClient();
  }
}
