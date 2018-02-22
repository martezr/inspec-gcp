# InSpec for Google Cloud Platform (GCP)

## Roadmap

This repository is the development repository for InSpec for GCP.

As of now, GCP resources are implemented as an InSpec resource pack. It will ship with the required resources to write your own GCP tests.

```
├── README.md - this readme
└── libraries - contains GCP resources
```


## Requirements

In order to utilize the GCP InSpec resource pack the following software must be installed on the system.

* InSpec
* google-api-client ruby gem
* googleauth ruby gem
* google-cloud ruby gem

## Get started

Before running the profile with InSpec, define environment variables with your GCP credentials.  InSpec supports the following variables:

- `GOOGLE_APPLICATION_CREDENTIALS`

Those variables are defined in [GCP Docs](https://cloud.google.com/docs/authentication/getting-started)

## Use the resources

Since this is a InSpec resource pack, it only defines InSpec resources. It includes example tests only. You can easily use the GCP InSpec resources in your tests do the following:

### Create a new profile

```
inspec init profile gcp-compliance
```

### Adapt the `inspec.yml`

```
name: my-profile
title: My own GCP profile
version: 0.1.0
depends:
  - name: gcp
    url: https://github.com/martezr/inspec-gcp/archive/master.tar.gz
```

### Add controls

Since your profile depends on the resource pack, you can use those resources in your own profile:

```
control "gcp-1" do
  impact 0.7
  title 'Check development project'

  describe gcp_project('silicon-vertex-398188') do
    it { should exist }
    its('name') { should eq 'My First Project' }
    its('project_number') { should eq '3934801284823' }
    its('lifecycle_state') { should eq 'ACTIVE' }
  end

end
```

### Available Resources

 * `gcp_instance` - Verifies settings for a GCP instance
 * `gcp_project` - Verifies settings for a GCP project
 * `gcp_storage` - Verifies settings for a GCP bucket

### Roadmap

 * `gcp_iam`
 * `gcp_container`

 ...


## Tests

### Unit tests

To execute the unit tests, run:

```
bundle exec rake test
```

### Integration tests

To run the integration tests, please make sure all required environment variables are set. We use terraform to create the GCP setup and InSpec to verify the all aspects. If you want to use a specific terraform environment, set environment variable `INSPEC_TERRAFORM_ENV`. Integration tests can be executed via:

```
bundle exec rake test:integration
```

This task sets up test GCP resources, runs the integration tests, and then cleans up the resources.  To perform these tasks independently, please call them individually:

* `bundle exec rake test:configure_test_environment`
* `bundle exec rake test:setup_integration_tests`
* `bundle exec rake test:run_integration_tests`
* `bundle exec rake test:cleanup_integration_tests`
* `bundle exec rake test:destroy_test_environment`
