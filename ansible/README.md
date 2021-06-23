# Ansible Playbook Initial Flow

The playbook `deploySplunk.yaml` contains all playbooks in order of operations to deploy Splunk enterprise initially and to update any configuration.  Running the entire deployment is time consuming though so running an individual playbooks to update the deployment server, cluster master, license master, indexer (boot strap files), etc, would be more time efficient.

# Playbooks called in deploySplunk.yaml

* `enableOsFips.yaml` (enables FIPs for REHL7 optional)
  - runs bash script to enable FIPS at OS level for REHL7 servers.  Server needs to have internet access or a satellite server to download packages
* `installSplunkEnterprise.yaml`
  - Will wget the splunk rpm package from Splunk's download site
  - prep the server and run the rpm installer.  
  - re-permission the /opt/splunk directory with `chmod -R 755` and `chown -R splunk:splunk`
  - Finishes with boot strapping the splunkd service with the created splunk account as a systemd managed service, Enabling and starting the service
* `installSplunkUf.yaml`
  - Will wget the splunk universal forwarder rpm package from Splunk's download site
  - prep the endpoint and run the rpm installer.  
  - re-permission the /opt/splunkforwarder directory with `chmod -R 755` and `chown -R splunk:splunk`
  - Finishes with boot strapping the splunkd service with the created splunk account as a systemd managed service, Enabling and starting the service
* `createSplunkDataDisks.yaml` (optional)
  - Creates the data disks in which splunk indexed data is stored.  This is geared towards indexers.  Optional if you want to do this manually
* `configure_standalone.yaml`
  - boot straps a standalone Splunk server.  This server would serve as a SH, IDXR, LM and potentially DS
* `configure_cm.yaml`
  - boot straps and loads configuration apps for cluster master. you can also use this to load up apps into your `master-apps` directory
* `configure_ds.yaml`
  - probably the most critical playbook aside from the `installSplunkEnterprise.yaml`.  this boot straps and loads all configuration apps for the deployment server and loads the deployment-apps directory which will be pushed out to participating splunk roles.  Both splunk enterprise and universal forwarders
* `configure_shs.yaml`
  - boot straps search head roles with `deploymentclient.conf` to point it to the correct deployment server
* `configure_lm.yaml`
  - boot straps search head roles with `deploymentclient.conf` to point it to the correct deployment server
  - copies .lic license file into the correct directory
  - the associated app `org_all_lm_license_server` will reference this file
* `configure_idxrs.yaml`
  - boot straps indexer roles with `deploymentclient.conf` to point it to the correct deployment server
* `configure_idxrs_site1.yaml`
  - in a multisite indexer configuration, this bootstraps indexers which are in site 1 with the correct server.conf file to give it site 1 affinity
* `configure_idxrs_site2.yaml`
  - in a multisite indexer configuration, this bootstraps indexers which are in site 2 with the correct server.conf file to give it site 2 affinity
* `changeSplunkHostname.yaml` (optional)
  - changes the splunk hostname to whatever the ansible inventory name is for the host.  This playbook is optional.  
* `restartSplunk.yaml`
  - restarts splunk  



# Playbook Breakdown

* `enableOsFips.yaml`
* `applyClusterBundle.yaml`
* `baseLineToUF.yaml`
* `changeSplunkHostname.yaml`
* `configure_cm.yaml`
* `configure_deployer.yaml`
* `configure_deploymentClients.yaml`
* `configure_dfs.yaml`
* `configure_dmc.yaml`
* `configure_ds.yaml`
* `configure_idxrs.yaml`
* `configure_idxrs_site1.yaml`
* `configure_idxrs_site2.yaml`
* `configure_lm.yaml`
* `configure_shs.yaml`
* `configure_standalone.yaml`
* `configure_subordinate_ds.yaml`
* `configure_syslog.yaml`
* `createSplunkDataDisks.yaml`
* `deploySplunk.yaml`
* `enableBootStrap.yaml`
* `enableOsFips.yaml`
* `fixkvstore_splunkkey.yaml`
* `installSplunkEnterprise.yaml`
* `installSplunkUf.yaml`
* `installSyslog.yaml`
* `modKey.yaml`
* `removeBrokenAppDirectory.yaml`
* `restartSplunk.yaml`
* `restartSplunkwDebug.yaml`
* `splunkCommandsDS.yaml`
* `splunkCommandsIdxr.yaml`
* `uninstallSplunkEnterprise.yaml`
* `upgradeSplunkEnterprise.yaml`
