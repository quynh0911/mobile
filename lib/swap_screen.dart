import 'package:blockchain_project/contanst/colors.dart';
import 'package:blockchain_project/provider/wallet_provider.dart';
import 'package:blockchain_project/widget/coin_balance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'contanst/address.dart';

class DexScreen extends StatelessWidget {
  const DexScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => WalletProvider(), child: const SwapScreen());
  }
}

class SwapScreen extends StatefulWidget {
  const SwapScreen({Key? key}) : super(key: key);

  @override
  _SwapScreenState createState() {
    return _SwapScreenState();
  }
}

class _SwapScreenState extends State<SwapScreen> {
  List<String> listDexs = ['Uniswap', 'Pancakeswap', 'Sushiswap'];
  List<String> coins = ['Ethereum', 'DAI', 'USDC'];
  TextEditingController numberFirst = TextEditingController();
  TextEditingController numberSecond = TextEditingController();
  String dexGW = 'Uniswap';
  String firstCoin = 'Ethereum';
  String secondCoin = 'DAI';

  @override
  void dispose() {
    numberFirst.dispose();
    numberSecond.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var wallet = Provider.of<WalletProvider>(context);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Dex gateway'),
            backgroundColor: Colors.indigoAccent,
            centerTitle: true,
          ),
          body: wallet.isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  semanticsLabel: 'Loading',
                ))
              : SingleChildScrollView(
                  // decoration: const BoxDecoration(
                  //     image: DecorationImage(
                  //   image: AssetImage('assets/images/splash.jpg'),
                  //   fit: BoxFit.fill,
                  // )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CoinBalance(
                                icon: 'assets/images/coins/ethereum.png',
                                name: 'Ethereum',
                                balance: wallet.ethBalance,
                                color: Colors.indigoAccent),
                            CoinBalance(
                                icon: 'assets/images/coins/dai.png',
                                name: '  DAI   ',
                                balance: wallet.daiBalance,
                                color: Colors.indigoAccent),
                            CoinBalance(
                                icon: 'assets/images/coins/ethereum.png',
                                name: '  USDC  ',
                                balance: wallet.usdcBalance,
                                color: Colors.indigoAccent),
                            CoinBalance(
                                icon: 'assets/images/coins/ethereum.png',
                                name: '  BUSD  ',
                                balance: wallet.busdBalance,
                                color: Colors.indigoAccent)
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      /* Expanded(
                        child:*/
                      Container(
                        width: double.infinity,
                        // height: 400,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            // gradient: LinearGradient(
                            //   begin: Alignment.topLeft,
                            //   end: Alignment.bottomRight,
                            //   colors: [
                            //     Colors.blueAccent,
                            //     Colors.redAccent,
                            //   ],
                            // ),
                            borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text(
                                  'Hoán đổi',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 20),
                                ),

                                // padding:const EdgeInsets.all(10),
                                DropdownButton<String>(
                                  items: listDexs.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Container(
                                        color: Colors.transparent,
                                        child: Text(
                                          value,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    wallet.setFirstBalance(value.toString());
                                    dexGW = value.toString();
                                    // print(wallet.firstCoin);
                                  },
                                  value: dexGW,
                                ),
                              ],
                            ),
                            // const Text('Uniswap'),
                            DropdownButton<String>(
                              items: coins.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Text(
                                      value,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                wallet.setFirstBalance(value.toString());
                                firstCoin = value.toString();
                                // print(wallet.firstCoin);
                              },
                              value: firstCoin,
                            ),
                            TextField(
                              controller: numberFirst,
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(height: 20),
                            Container(
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.indigoAccent),
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.all(8),
                              child: const Icon(
                                Icons.arrow_downward_rounded,
                                color: Colors.white,
                              ),
                            ),
                            DropdownButton<String>(
                              items: coins.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Container(
                                    color: Colors.transparent,
                                    child: Text(
                                      value,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                wallet.setFirstBalance(value.toString());
                                secondCoin = value.toString();
                                // print(wallet.firstCoin);
                              },
                              value: secondCoin,
                            ),
                            // TextField(
                            //   controller: numberSecond,
                            //   // decoration: InputDecoration(
                            //   //   // hintText: wallet.secondCoin
                            //   // ),
                            //   enabled: false,
                            //   keyboardType: TextInputType.number,
                            // ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(15),
                                  primary: Colors.indigoAccent,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30))),
                                ),
                                onPressed: () async{
                                  if (firstCoin == secondCoin) {
                                    showCupertinoDialog(
                                        context: context,
                                        builder: (context) =>
                                            CupertinoAlertDialog(
                                                title:const Text("Cảnh báo", ),
                                                content: const Text(
                                                    "Hai token giống nhau"),
                                            actions: [
                                              CupertinoDialogAction(child:const Text('OK'), onPressed: (){
                                                Navigator.pop(context);
                                              },)
                                            ],));
                                  } else {
                                    if(firstCoin == 'Ethereum'){
                                      BigInt amountIn = BigInt.parse(numberFirst.text/* * 0.0000000000000000001*/) /** BigInt.from(1000000000000000000)*/;
                                      // print(amountIn);
                                      String addressOut = Address.mapCoin[secondCoin]!;
                                      // print(addressOut);
                                      wallet.setLoading(true);
                                      await wallet.swapETHToToken(amountIn, addressOut);
                                      wallet.setLoading(false);
                                    } else if(secondCoin == 'Ethereum'){
                                      BigInt amountIn = BigInt.parse(numberFirst.text);
                                      // print(amountIn);
                                      String addressIn = Address.mapCoin[firstCoin]!;
                                      // print(addressOut);
                                      wallet.setLoading(true);
                                      await wallet.swapTokenToETH(amountIn, addressIn);
                                      wallet.setLoading(false);
                                    } else {
                                      String addressOut = Address.mapCoin[secondCoin]!;
                                      String addressIn = Address.mapCoin[firstCoin]!;
                                      BigInt amountIn = BigInt.parse(numberFirst.text);
                                      wallet.setLoading(true);
                                      await wallet.swapTokenToToken(amountIn, addressIn, addressOut);
                                      wallet.setLoading(false);
                                    }
                                  }
                                },
                                child: const SizedBox(
                                  width: 100,
                                  child: Text(
                                    'Swap',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ))
                          ],
                        ),
                      ),
                      // ),
                      const SizedBox(height: 30)
                    ],
                  ),
                )),
    );
  }
}
