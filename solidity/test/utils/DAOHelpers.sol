// SPDX-License-Identifier: MIT
pragma solidity =0.8.17;

import {PluginRepoFactory} from '@aragon/osx/framework/plugin/repo/PluginRepoFactory.sol';
import {PluginRepo} from '@aragon/osx/framework/plugin/repo/PluginRepo.sol';

import {AddressRepository} from 'test/utils/AddressRepository.sol';
import {createERC1967Proxy} from '@aragon/osx/utils/Proxy.sol';
import {DAO} from '@aragon/osx/core/dao/DAO.sol';
import {DAOFactory} from '@aragon/osx/framework/dao/DAOFactory.sol';
import {PluginSetupRef} from '@aragon/osx/framework/plugin/setup/PluginSetupProcessorHelpers.sol';
import {IPluginSetup} from '@aragon/osx/framework/plugin/setup/IPluginSetup.sol';
import {PluginSetupProcessor} from '@aragon/osx/framework/plugin/setup/PluginSetupProcessor.sol';

contract DAOHelpers is AddressRepository {
  function deployRepo(
    string memory network,
    string memory subdomain,
    address pluginSetup,
    address owner,
    bytes memory releaseMetadata,
    bytes memory buildMetadata
  ) public returns (PluginRepo repo) {
    PluginRepoFactory repoFactory = PluginRepoFactory(getAddress(network, 'PluginRepoFactory'));
    repo = PluginRepo(
      repoFactory.createPluginRepoWithFirstVersion({
        _subdomain: subdomain,
        _pluginSetup: pluginSetup,
        _maintainer: owner,
        _releaseMetadata: releaseMetadata,
        _buildMetadata: buildMetadata
      })
    );
  }

  function deployMockRepo(string memory network, address pluginSetup, address owner) external returns (PluginRepo) {
    return deployRepo({
      network: network,
      subdomain: 'mock-69420',
      pluginSetup: pluginSetup,
      owner: owner,
      releaseMetadata: bytes('0x00'),
      buildMetadata: bytes('0x00')
    });
  }

  function deployEmptyDao(
    string memory network,
    bytes memory metadata,
    address initialOwner,
    address trustedForwarder,
    string memory daoURI
  ) public returns (DAO dao) {
    DAOFactory factory = DAOFactory(getAddress(network, 'DAOFactory'));
    dao = DAO(payable(createERC1967Proxy(factory.daoBase(), bytes(''))));
    dao.initialize({
      _metadata: metadata,
      _initialOwner: initialOwner,
      _trustedForwarder: trustedForwarder,
      daoURI_: daoURI
    });
  }

  function deployAdminDao(
    string memory network,
    string memory subdomain,
    bytes memory metadata,
    address initialOwner,
    address trustedForwarder,
    string memory daoURI
  ) public returns (DAO dao) {
    DAOFactory factory = DAOFactory(getAddress(network, 'DAOFactory'));

    DAOFactory.DAOSettings memory settings = DAOFactory.DAOSettings({
      trustedForwarder: trustedForwarder,
      daoURI: daoURI,
      metadata: metadata,
      subdomain: subdomain
    });

    DAOFactory.PluginSettings[] memory pluginSettingsArray = new DAOFactory.PluginSettings[](1);
    pluginSettingsArray[0] = DAOFactory.PluginSettings({
      pluginSetupRef: getPluginSetupRef(1, 1, PluginRepo(getAddress(network, 'admin_repo'))),
      data: abi.encode(initialOwner)
    });
    dao = factory.createDao({_daoSettings: settings, _pluginSettings: pluginSettingsArray});
  }

  function deployMockDao(string memory network, address owner) public returns (DAO dao) {
    return deployAdminDao({
      network: network,
      subdomain: 'testing69420',
      metadata: bytes('0x00'),
      initialOwner: owner,
      trustedForwarder: address(0),
      daoURI: 'https://example.xyz'
    });
  }

  function getPluginSetupRef(
    uint8 release,
    uint16 build,
    PluginRepo pluginRepo
  ) public pure returns (PluginSetupRef memory) {
    return PluginSetupRef({versionTag: PluginRepo.Tag({release: release, build: build}), pluginSetupRepo: pluginRepo});
  }

  function prepareInstall(
    string memory network,
    DAO dao,
    PluginRepo repo,
    uint16 build,
    uint8 release,
    bytes memory data
  ) public returns (address plugin, IPluginSetup.PreparedSetupData memory preparedSetupData) {
    PluginSetupProcessor psp = PluginSetupProcessor(getAddress(network, 'PluginSetupProcessor'));

    return psp.prepareInstallation({
      _dao: address(dao),
      _params: PluginSetupProcessor.PrepareInstallationParams({
        pluginSetupRef: getPluginSetupRef(release, build, repo),
        data: data
      })
    });
  }
}
