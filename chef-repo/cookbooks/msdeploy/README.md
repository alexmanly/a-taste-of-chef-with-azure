msdeploy Cookbook
=================
This cookbook provides support for using MSDeploy inside Chef cookbooks

Requirements
------------
#### cookbooks
- `webpi` - msdeploy needs webpi to install MSDeploy

-----
#### msdeploy::install
This recipe installs MSDeploy 3.0 via Web Platform Installer

e.g.
Just include `msdeploy::install` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[msdeploy:install]"
  ]
}
```

#### msdeploy_sync resource
This resource allows you to sync two places (e.g. package and IIS site) using MSDeploy. 

There is only one action `:sync`.

To run synchornisation you need to provide values for two attributes: `source` and `dest`. Both of them has the same format: `:provider => 'provider_path'`. 
As provider you can pass any valid MSDeploy provider like `contentPath`, `package`, etc. `provider_path` must be valid path for given provider (e.g. path to zip package). If provider does not require path, pass `nil`.

License and Authors
-------------------
Authors: Maciej T. Nowak
