I use these three scripts when we're rebooting our Orion platform, to minimise alerts going to our support desk. 
We originally just unmanaged the entire estate, but this does not preserve devices that are/were already un-managed. 
So to overcome this I create these scripts, they're numbered in the order you would run them: 

The first script queries the API for a list of NodeIDs for all devices that are currently managed, which is then placed into a file. 
The second scrpt reads these NodeIDs and un-manages them. 
And (once the service impacting work has finished on the Orion servers) the third script re-manages these devices. 

On our system with about 1500 monitored devices the 2nd and 3rd scripts take ~10 minutes to run.

You will need to update the variables for the orion.fqdn, username and password to match your Orion system.
