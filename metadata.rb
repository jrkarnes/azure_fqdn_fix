name             'azure_fqdn_fix'
maintainer       'PerfectCube'
maintainer_email 'justin@perfectcube.co'
license          'MIT'
description      'Fixes node FQDNs on Azure without hassle'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.3'
depends "ohai"
source_url "https://github.com/jrkarnes/azure_fqdn_fix"
issues_url "https://github.com/jrkarnes/azure_fqdn_fix/issues"

supports 'ubuntu', '>= 14.04'