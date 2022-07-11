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
  late double daiWallet;
  late double usdcWallet;
  late double busdWallet;
  late double ethWallet;
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
    ethWallet = ethBalance.toDouble();
    firstBalance = ethBalance;
    // daiBalance = BigInt.from(10000000);
    daiBalance = await dai.checkBalance();
    daiWallet = daiBalance /BigInt.from(10).pow(18);
    secondBalance = daiBalance;
    // usdcBalance = BigInt.from(10000000);
    usdcBalance = await usdc.checkBalance();
    usdcWallet = usdcBalance /BigInt.from(10).pow(6);
    busdBalance = await busd.checkBalance();
    busdWallet = busdBalance / BigInt.from(10).pow(18);
    isLoading = false;
    notifyListeners();
  }

  swapETHToToken(BigInt amountIn, String addressOut, BigInt amountInTest) async {
    // client = EthClient(Address.PRIVATE_KEY, Address.RPC_URL);
    // uniswapGW = UniswapGW(Address.Uniswap, client);
    final test = await uniswapGW.swapFromETHToToken(
        addressOut, amountIn, amountInTest);
    await Future.delayed(const Duration(seconds: 2));
    final eth = await client.getBalance();
    ethBalance = eth.getInEther;
    ethWallet = ethBalance.toDouble();
    daiBalance = await dai.checkBalance();
    daiWallet = daiBalance / BigInt.from(10).pow(18);
    usdcBalance = await usdc.checkBalance();
    usdcWallet = usdcBalance /BigInt.from(10).pow(6);
    busdBalance = await busd.checkBalance();
    busdWallet = busdBalance /BigInt.from(10).pow(18);
    notifyListeners();
  }

  swapTokenToToken(BigInt amountIn,String addressIn, String addressOut) async {
    // final amountOutIn = BigInt.from(1);
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
        await Future.delayed(const Duration(seconds: 10));
        break;
      case Address.USDC:
        await usdc.approve(uniswapGW.address, amountIn);
        await Future.delayed(const Duration(seconds: 10));
        break;
      case Address.BUSD:
        await busd.approve(uniswapGW.address, amountIn);
        await Future.delayed(const Duration(seconds: 10));
        break;
    }
    final test = await uniswapGW.swap(
        addressIn, addressOut, amountIn,  Address.address);
    await Future.delayed(const Duration(seconds: 15));
    final eth = await client.getBalance();
    ethBalance = eth.getInEther;
    ethWallet = ethBalance.toDouble();
    daiBalance = await dai.checkBalance();
    daiWallet = daiBalance / BigInt.from(10).pow(18);
    usdcBalance = await usdc.checkBalance();
    usdcWallet = usdcBalance /BigInt.from(10).pow(6);
    busdBalance = await busd.checkBalance();
    busdWallet = busdBalance /BigInt.from(10).pow(18);
    notifyListeners();
  }

  swapTokenToETH(BigInt amountIn, String addressIn) async {
    // final amountOutIn = BigInt.from(0);
    // client = EthClient(Address.PRIVATE_KEY, Address.RPC_URL);
    // uniswapGW = UniswapGW(Address.Uniswap, client);
    switch(addressIn){
      case Address.DAI:
        await dai.approve(uniswapGW.address, amountIn);
        await Future.delayed(const Duration(seconds: 10));
        break;
      case Address.USDC:
        await usdc.approve(uniswapGW.address, amountIn);
        await Future.delayed(const Duration(seconds: 10));
        break;
      case Address.BUSD:
        await busd.approve(uniswapGW.address, amountIn);
        await Future.delayed(const Duration(seconds: 10));
        break;
    }

    // try {
      final test = await uniswapGW.swapFromTokenToETH(
          addressIn, amountIn);
    // } catch (e){
    //   isLoading
    //   = false;
    // }
    await Future.delayed(const Duration(seconds: 15));
    final eth = await client.getBalance();
    ethBalance = eth.getInEther;
    ethWallet = ethBalance.toDouble();
    daiBalance = await dai.checkBalance();
    daiWallet = daiBalance / BigInt.from(10).pow(18);
    usdcBalance = await usdc.checkBalance();
    usdcWallet = usdcBalance /BigInt.from(10).pow(6);
    busdBalance = await busd.checkBalance();
    busdWallet = busdBalance /BigInt.from(10).pow(18);
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
