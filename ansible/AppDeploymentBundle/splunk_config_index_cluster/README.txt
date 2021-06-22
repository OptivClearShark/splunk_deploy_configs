These files are not intended to all be dumped into the master-apps
directory of a cluster master. Unlike the deployment server (which is
pick-and-choose), the cluster master pushes *all* application content
from its master-apps directory to its peers. Don't do that; you may
end up with seven cluster masters, rather than a cluster master and
six peers!

Next, most of these don't live in the master-apps directory
anyway. They're intended to be parted out to the etc/apps directory of
a node (per its intended role) to bootstrap the process of getting the
cluster up and running. In particular, the _site_n_ app would be
customized per site, and placed by hand on the target indexer(s).
