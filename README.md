# azure_fqdn_fix Cookbook

Adjusts /etc/hosts to fix hostname -f which is read by OHAI and sets a node's FQDN

## Requirements

Currently this cookbook is designed to work only on Ubuntu flavored VMs on the AZURE PLATFORM.

### Platforms

- Ubuntu Linux 14.04+
- Support for other Liunx Platforms will not be done by me, but can/will be supported via fork & pull


### Chef

- Chef 12.0 or later

### Cookbooks

- Ohai

## Attributes

### Default

| Key | Type | Description | Default |
|:-:|:-:|:-:|:-:|
| `['azure_fqdn_fix']['domain']` | String | The domain name of your node | 'example.of.long.domain.com' |
| `['azure_fqdn_fix']['hostname']` | String | The hostname your node | 'default-hostname' |

If your browser does not support markdown tables, the table is better formatted as JSON here:

```json
{
  'azure_fqdn_fix' :
  {
      'domain' : 
      {
         'type' : 'String',
         'Description' : "The domain name of your node",
         'Default' : 'example.of.long.domain.com'
      },
      'hostname' : 
      {
         'type' : 'String',
         'Description' : "The hostname name of your node",
         'Default' : 'default-hostname'
      }
  }
}
```

## Usage

`node['domain']` and `node['hostname']` are not a reliable way of putting together a node's FQDN if it is hosted on Azure. Once you set up your public-ip DNS resolver name in the Azure portal, you are ready to use this recipe in your `run_list`.

`['azure_fqdn_fix']['hostname']` is whatever you set your public resolver hostname to. It is whatever you put in the space that you fill in.

`['azure_fqdn_fix']['domain']` is the portion of the DNS resolver hostname that _you cannot change_. It is usually underneath the editable region and has the format of `region.cloudapp.azure.com`

### azure_fqdn_fix::default

1. Set the attributes `node['azure_fqdn_fix']['domain']` and `node['azure_fqdn_fix']['hostname']` in your node through some means
2. Include `azure_fqdn_fix` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[azure_fqdn_fix]"
  ]
}
```

### Tips

1. I highly recommend setting the `['azure_fqdn_fix']['domain']` at the environment scope since most of your VM's in a cluster will be in the same geographical resource center.
2. It is highly advised that you set up the DNS resolver BEFORE you run your bootstrap of your node because you can pass the --json-attributes flag (-j for short) and configure the public resolver as `{'azure_fqdn_fix' : { 'hostname' : 'I-picked-this-hostname' }}`. If you didn't set the `domain` attribute at the environment scope, you should include it in your json attributes hash.
3. If you are fixing the FQDN of a node which has been deployed with this recipe:
   1. Follow usage above
   2. Run `sudo chef-client` to run the recipe
   3. Run `ohai` to update the node["fqdn"] attribute
   4. Run `sudo chef-client` to report the updated FQDN to the chef-server

## Gotcha's

If you have a recipe in your `run_list` which for some reason changes the file permissions or ownership of the files in the `/etc/` directory then you should run this recipe *before* the one(s) that do(es) because this recipe will alter the owner, group, and mode of the `/etc/hosts` file.

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

License: MIT
Contributors: Justin Karnes
