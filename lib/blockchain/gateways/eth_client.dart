import 'package:dart_web3/dart_web3.dart';
import 'package:http/http.dart';

class EthClient {
  factory EthClient(String privateKey, String rpcUrl) => EthClient._(
        EthPrivateKey.fromHex(privateKey),
        Web3Client(
          rpcUrl,
          Client(),
        ),
      );

  EthClient._(this.credentials, this.client);

  final Web3Client client;

  final Credentials credentials;

  Future<String> sendNewTransaction(DeployedContract contract,
      ContractFunction function, List<dynamic> params,
      {BigInt? amountIn}) {
    if (amountIn == null) {
      return client.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract, function: function, parameters: params),
        chainId: 31337,

      );
    }
    return client.sendTransaction(
      credentials,
      Transaction.callContract(
        value: EtherAmount.fromUnitAndValue(EtherUnit.ether, amountIn),
          contract: contract,
          function: function,
          parameters: params,
          ),
      chainId: 31337,

    );
  }

  Future<List<dynamic>> call(
    DeployedContract contract,
    ContractFunction function,
    List<dynamic> params,
  ) {
    return client.call(
      contract: contract,
      function: function,
      params: params,
    );
  }

  getBalance() async {
    return client.getBalance(await credentials.extractAddress());
  }
}
