import 'package:blockchain_project/blockchain/contracts/ierc20.dart';
import 'package:blockchain_project/blockchain/gateways/eth_client.dart';
import 'package:blockchain_project/blockchain/gateways/sushi.dart';
import 'package:blockchain_project/blockchain/gateways/uniswap.dart';
import 'package:blockchain_project/contanst/address.dart';
import 'package:dart_web3/dart_web3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() async {
  late final EthClient client;
  late final IERC20 weth;
  late final IERC20 aWeth;
  late final IERC20 dai;
  late final usdc;
  late final UniswapGW uniswap;
  late final SushiGW sushi;
  late final IERC20 busd;
  setUp(() async {
    client = EthClient(Address.PRIVATE_KEY, Address.RPC_URL);
    weth = IERC20(Address.WETH, client);
    dai = IERC20(Address.DAI, client);
    usdc = IERC20(Address.USDC, client);
    busd = IERC20(Address.BUSD, client);
    uniswap = UniswapGW(Address.Uniswap, client);
    sushi = SushiGW(Address.Sushi, client);
  });

//swap dai sang eth
//   test('SwapFromTokenTOETH', () async {
//     // var amountOutIn = await uniswap.getAmountOut(
//     //     Address.WETH,
//     //     Address.DAI,
//     //     BigInt.from(10)
//     // );
//     final amountOutIn = BigInt.from(1);
//     // await Future.delayed(const Duration(seconds: 3));
//     // expect(amountOutIn,BigInt.from(11478));
//     var amountIn = BigInt.from(1000);
//     // await weth.approve(uniswap.gw.address.hex,  amountIn);
//     // await dai.approve(Address.PRIVATE_KEY, amountOutIn);
//     var k = await dai.checkBalance();
//     var firstWethBalance =await client.getBalance();
//     await Future.delayed(const Duration(seconds: 3));
//     // dai.approve(uniswap.gw.address.hex, BigInt.from(1000));
//     final test = await uniswap.swapFromTokenToETH(Address.DAI, amountIn ,amountOutIn, Address.address);
//     await Future.delayed(const Duration(seconds: 5));
//     var kafter = await dai.checkBalance();
//     var secondWethBalance =await client.getBalance();
//     await Future.delayed(const Duration(seconds: 3));
//     expect(k - kafter, greaterThan(BigInt.zero));
//     expect(secondWethBalance.getInWei  - firstWethBalance.getInWei, greaterThan(BigInt.zero));
//   });


  // swap eth sang dai
  // test('SwapFromETHToToken', () async {
  //   // var amountOutIn = await uniswap.getAmountOut(
  //   //     Address.WETH,
  //   //     Address.DAI,
  //   //     BigInt.from(10)
  //   // );
  //   final amountOutIn = BigInt.from(1);
  //   await Future.delayed(const Duration(seconds: 3));
  //   // expect(amountOutIn,BigInt.from(11478));
  //   var amountIn = BigInt.from(10);
  //   // await weth.approve(uniswap.gw.address.hex,  amountIn);
  //   // await dai.approve(Address.PRIVATE_KEY, amountOutIn);
  //   await Future.delayed(const Duration(seconds: 3));
  //   // // weth.approve(uniswap.gw.address.hex, BigInt.from(100));
  //   final test = await uniswap.swapFromETHToToken(Address.DAI, amountIn ,amountOutIn, Address.address);
  //   await Future.delayed(const Duration(seconds: 5));
  //   expect(amountOutIn, equals(BigInt.from(1)));
  // });

  test('swap', () async{
    final amountIn = BigInt.from(10000000);
    final amountOutIn = await uniswap.getAmountOut(
            Address.DAI,
        Address.USDC,
            amountIn
        );
    //=> đang ra 0, lỗi j ta, yup, nãy t đổi từ weth sang dai là tầm 13344
    expect(amountOutIn, greaterThan(BigInt.zero));
    // final amountOutIn = BigInt.from(1);
    await Future.delayed(const Duration(seconds: 3));
    var k = await dai.checkBalance();
    var t =await busd.checkBalance();
    // await dai.approve(uniswap.gw.address.hex, BigInt.from(1000000000));
    await Future.delayed(const Duration(seconds: 3));
    final test1 = await uniswap.swap(Address.DAI, Address.BUSD, amountIn ,amountOutIn, Address.address);
    await Future.delayed(const Duration(seconds: 5));
    var kafter = await dai.checkBalance();
    var tafter  =await busd.checkBalance();
    await Future.delayed(const Duration(seconds: 3));
    expect(-tafter + t, lessThan(BigInt.zero));
    expect(k - kafter, greaterThan(BigInt.zero));
  });
//
//   test("Check Balance", () async {
//     final firstWethBalance =await client.getBalance();
//     // final t =await busd.checkBalance();
//     // expect(
//     //   t,
//     //   equals(BigInt.parse('0')),
//     // );
//     // expect(
//     //   firstWethBalance.getInEther,
//     //   lessThan(BigInt.parse('92')),
//     // );
//     // dai = IERC20(Address.DAI, client);
//     // final k = await dai.checkBalance();
//     // expect(
//     //   k,
//     //   greaterThan(BigInt.parse('0')),
//     // );
//
//     final firstDaiBalance = await weth.checkBalance();
//     expect(firstDaiBalance, equals(BigInt.parse('0')));
//
//   });
}
