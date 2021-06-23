# Ansible Playbook Initial Flow

The playbook `deploySplunk.yaml` contains all playbooks in order of operations to deploy Splunk enterprise initially and to update any configuration.  Running the entire deployment is time consuming though so running an individual playbooks to update the deployment server, cluster master, license master, indexer (boot strap files), etc, would be more time efficient.

# Playbooks called in deploySplunk.yaml

* enableOsFips.yaml (enables FIPs for REHL7 optional)
* installSplunkEnterprise.yaml
Will, wget the splunk rpm package, prep the server and run the rpm installer.  Finishes with boot strapping the splunkd service with the created splunk account
* installSplunkUf.yaml
* createSplunkDataDisks.yaml (optional)
* configure_standalone.yaml
* configure_cm.yaml
* configure_ds.yaml
* configure_shs.yaml
* configure_lm.yaml
* configure_idxrs.yaml
* configure_idxrs_site1.yaml
* configure_idxrs_site2.yaml
* configure_dfs.yaml
* configure_deployer.yaml
* configure_subordinate_ds.yaml
* changeSplunkHostname.yaml
* restartSplunk.yaml



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
