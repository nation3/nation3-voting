//SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

contract AddressRepository {
  mapping(string => mapping(string => address)) public addresses;

  constructor() {
    addresses['goerli']['managingDAO'] = 0xB76F8d3512497040a96E77141c951a5374F24Eb9;
    addresses['goerli']['DAO_ENSSubdomainRegistrar_Implementation'] = 0x394B49Cc32Dc81B8EaCdeb62A6Fa66F31D1D022c;
    addresses['goerli']['DAO_ENSSubdomainRegistrar'] = 0xC62820f3E74cC82F89100032Ad7F04682F9EdaE0;
    addresses['goerli']['Plugin_ENSSubdomainRegistrar_Implementation'] = 0xbcE9b6fE957464aF2B739337bd1a936EbFCB5B48;
    addresses['goerli']['Plugin_ENSSubdomainRegistrar'] = 0xd5656b6d1bc0354073f62AAbc1430530C331979c;
    addresses['goerli']['DAORegistry_Implementation'] = 0xa796AC80af77a52AdA92778d8fb6133792480B77;
    addresses['goerli']['DAORegistry'] = 0xd51ac19130A73455F8B3b1c26aFea21D6bA88E54;
    addresses['goerli']['PluginRepoRegistry_Implementation'] = 0x3861Ef32c1bFcdd53E9AaE4af1C9f47390c17fBf;
    addresses['goerli']['PluginRepoRegistry'] = 0x970Eb7Dd57c9F0dc4c5a10c06653d1103946b508;
    addresses['goerli']['PluginRepoFactory'] = 0x477EB3b39C92c38B43778266b09471285e0F7808;
    addresses['goerli']['PluginSetupProcessor'] = 0xE8B5d8D66a02CD1b9Bd32a4064D7ABa45F51305e;
    addresses['goerli']['DAOFactory'] = 0x1E4350A3c9aFbDbd70FA30B9B2350B9E8182449a;
    addresses['goerli']['AddresslistVotingSetup'] = 0x0B295EDeDF122E5A57d0661E1993f617dE1bEDF4;
    addresses['goerli']['TokenVotingSetup'] = 0x23a21113719ADaf2F360408b82E5cF73c3aA8217;
    addresses['goerli']['AdminSetup'] = 0x633845bB511DE83EA31b8717614d88fa7b569694;
    addresses['goerli']['MultisigSetup'] = 0x27469edD65132751aAA4d313d79Ff1b2Fa286380;
    addresses['goerli']['address_list_voting_repo'] = 0xbD293e27226EF2b85E84FADCF2d5135AbC52e50A;
    addresses['goerli']['token_voting_repo'] = 0xFCc843C48BD44e5dA5976a2f2d85772D59C5959E;
    addresses['goerli']['admin_repo'] = 0xF66348E9865bb0f29B889E7c0FE1BCf4acAb5f54;
    addresses['goerli']['multisig_repo'] = 0x92C090cffC592B1bC321aCfAF735057B876375F8;

    addresses['mainnet']['managingDAO'] = 0xf2d594F3C93C19D7B1a6F15B5489FFcE4B01f7dA;
    addresses['mainnet']['DAO_ENSSubdomainRegistrar_Implementation'] = 0xCe0B4124dea6105bfB85fB4461c4D39f360E9ef3;
    addresses['mainnet']['DAO_ENSSubdomainRegistrar'] = 0xE640Da5AD169630555A86D9b6b9C145B4961b1EB;
    addresses['mainnet']['Plugin_ENSSubdomainRegistrar_Implementation'] = 0x08633901DdF9cD8e2DC3a073594d0A7DaD6f3f57;
    addresses['mainnet']['Plugin_ENSSubdomainRegistrar'] = 0x35B62715459cB60bf6dC17fF8cfe138EA305E7Ee;
    addresses['mainnet']['DAORegistry_Implementation'] = 0xC24188a73dc09aA7C721f96Ad8857B469C01dC9f;
    addresses['mainnet']['DAORegistry'] = 0x7a62da7B56fB3bfCdF70E900787010Bc4c9Ca42e;
    addresses['mainnet']['PluginRepoRegistry_Implementation'] = 0xddCc39a2a0047Eb47EdF94180452cbaB14d426EF;
    addresses['mainnet']['PluginRepoRegistry'] = 0x5B3B36BdC9470963A2734D6a0d2F6a64C21C159f;
    addresses['mainnet']['PluginRepoFactory'] = 0x96E54098317631641703404C06A5afAD89da7373;
    addresses['mainnet']['PluginSetupProcessor'] = 0xE978942c691e43f65c1B7c7F8f1dc8cDF061B13f;
    addresses['mainnet']['DAOFactory'] = 0xA03C2182af8eC460D498108C92E8638a580b94d4;
    addresses['mainnet']['AddresslistVotingSetup'] = 0x360586dB62DA31327B2462BA27bEb3e48ebbf396;
    addresses['mainnet']['TokenVotingSetup'] = 0xB2A2b32b9d885C85d5b229C0509341c37CaE7483;
    addresses['mainnet']['AdminSetup'] = 0xBFD541bc4fcE14adf1Fb9258574D3cBF5f55a894;
    addresses['mainnet']['MultisigSetup'] = 0x8d6726Fe85Caa585d88FD8342ebEEE88d703E754;
    addresses['mainnet']['address_list_voting_repo'] = 0xC207767d8A7a28019AFFAEAe6698F84B5526EbD7;
    addresses['mainnet']['token_voting_repo'] = 0xb7401cD221ceAFC54093168B814Cc3d42579287f;
    addresses['mainnet']['admin_repo'] = 0xA4371a239D08bfBA6E8894eccf8466C6323A52C3;
    addresses['mainnet']['multisig_repo'] = 0x8c278e37D0817210E18A7958524b7D0a1fAA6F7b;

    addresses['mumbai']['managingDAO'] = 0xE1De373E219a0d19a0500e599adb903477bCA0f9;
    addresses['mumbai']['DAO_ENSSubdomainRegistrar_Implementation'] = 0xD5baCA29C944A28f1f568F7e69B119030914c15D;
    addresses['mumbai']['DAO_ENSSubdomainRegistrar'] = 0xC528B8AA6a4D0f21455a06b6D7A41fd795619C31;
    addresses['mumbai']['Plugin_ENSSubdomainRegistrar_Implementation'] = 0x99965D7cFFE21C4AC94526AAFEd33E9EaA27f004;
    addresses['mumbai']['Plugin_ENSSubdomainRegistrar'] = 0x2EfcED958034c3BC455273153C3e604D34C78e46;
    addresses['mumbai']['DAORegistry_Implementation'] = 0xE5058D785C934279Af1EF7E90BB5D58048829256;
    addresses['mumbai']['DAORegistry'] = 0x6dD0C8b7F9406206ceAA01B5576D9d46e9298f0E;
    addresses['mumbai']['PluginRepoRegistry_Implementation'] = 0xab27e29F579C870F66F48F4825A4D294AE540818;
    addresses['mumbai']['PluginRepoRegistry'] = 0xc796bB1AfEBc56daDF6CAcD2aDa78055e5381971;
    addresses['mumbai']['PluginRepoFactory'] = 0x4E7c97ab08c046A8e43571f9839d768ae84492e4;
    addresses['mumbai']['PluginSetupProcessor'] = 0x9227b311C5cecB416707F1C8B7Ca1b52649AabEc;
    addresses['mumbai']['DAOFactory'] = 0xc715336B5E7F10294F36CA09f19A0493070E2eFB;
    addresses['mumbai']['AddresslistVotingSetup'] = 0xfDB0E4AADEf463824F10D6a0455acdb50a81B746;
    addresses['mumbai']['TokenVotingSetup'] = 0xA8c6C249f4739A4d4d0949550a61de7A4b8FDa16;
    addresses['mumbai']['AdminSetup'] = 0x40a3EF0f0780e044EbDDEdAa9AB225158f315afd;
    addresses['mumbai']['MultisigSetup'] = 0x008472798D9818F8BfC08e7966bd9c5d8378FF6f;
    addresses['mumbai']['address_list_voting_repo'] = 0x71570268A86A80B5cCa3F5e430c2BAa3F4b26278;
    addresses['mumbai']['token_voting_repo'] = 0xaCa70D8c462940B839DE386BcDD4CACf745632cA;
    addresses['mumbai']['admin_repo'] = 0x0DF9b15550fF39149e491dDD154b28f587e0cD16;
    addresses['mumbai']['multisig_repo'] = 0x2c4690b8be39adAd4F15A69340d5035aC6E53eEF;

    addresses['polygon']['AddresslistVotingSetup'] = 0x622DB36633643E4A4075ecc3A309a4f0B942922a;
    addresses['polygon']['AdminSetup'] = 0x82aBAfBf46759358c705c7E323543A7Be47AbAf0;
    addresses['polygon']['managingDAO'] = 0x6d4FB6Ff01A172774f42789fcfcdd84E68c28494;
    addresses['polygon']['DAOFactory'] = 0x51Ead12DEcD31ea75e1046EdFAda14dd639789b8;
    addresses['polygon']['DAORegistry'] = 0x96E54098317631641703404C06A5afAD89da7373;
    addresses['polygon']['DAORegistry_Implementation'] = 0x5B3B36BdC9470963A2734D6a0d2F6a64C21C159f;
    addresses['polygon']['DAO_ENSSubdomainRegistrar'] = 0x07f49c49Ce2A99CF7C28F66673d406386BDD8Ff4;
    addresses['polygon']['DAO_ENSSubdomainRegistrar_Implementation'] = 0x35B62715459cB60bf6dC17fF8cfe138EA305E7Ee;
    addresses['polygon']['PluginRepoFactory'] = 0x6E924eA5864044D8642385683fFA5AD42FB687f2;
    addresses['polygon']['PluginRepoRegistry'] = 0xA03C2182af8eC460D498108C92E8638a580b94d4;
    addresses['polygon']['PluginRepoRegistry_Implementation'] = 0xE978942c691e43f65c1B7c7F8f1dc8cDF061B13f;
    addresses['polygon']['PluginSetupProcessor'] = 0x879D9dfe3F36d7684BeC1a2bB4Aa8E8871A7245B;
    addresses['polygon']['Plugin_ENSSubdomainRegistrar'] = 0x7a62da7B56fB3bfCdF70E900787010Bc4c9Ca42e;
    addresses['polygon']['Plugin_ENSSubdomainRegistrar_Implementation'] = 0xC24188a73dc09aA7C721f96Ad8857B469C01dC9f;
    addresses['polygon']['TokenVotingSetup'] = 0x03445b197271CB3BE5E453745eD98a05793a4538;
    addresses['polygon']['MultisigSetup'] = 0xD63A8Cfb0eec960C3e70F96a9e3F3091f3FD70b6;
    addresses['polygon']['address_list_voting_repo'] = 0x641DdEdc2139d9948e8dcC936C1Ab2314D9181E6;
    addresses['polygon']['token_voting_repo'] = 0xae67aea0B830ed4504B36670B5Fa70c5C386Bb58;
    addresses['polygon']['admin_repo'] = 0x7fF570473d0876db16A59e8F04EE7F17Ab117309;
    addresses['polygon']['multisig_repo'] = 0x5A5035E7E8aeff220540F383a9cf8c35929bcF31;
  }

  function getAddress(string memory _network, string memory _contract) public view returns (address addr) {
    addr = addresses[_network][_contract];
  }
}
