# gcp_instance

Use the `gcp_instance` InSpec audit resource to test properties of a single GCP instance.

## Examples

The following examples show how to use this InSpec audit resource.

### Test that a GCP instance does not exist

    describe gcp_instance(project: 'silicon-vertex-398188', zone: 'us-east1-b', name: 'inspec-test') do
      it { should_not exist }
    end

### Test that a GCP instance is running

    describe gcp_instance(name: 'prod-database') do
      its('status') { should eq 'running' }
    end

### Test that a GCP instance is using the correct image ID

    describe gcp_instance(name: 'my-instance') do
      its('image_id') { should eq 'ami-27a58d5c' }
    end

### Test that a GCP instance has the correct tag

    describe gcp_instance('i-090c29e4f4c165b74') do
      it { should have_network_tag('test') }
    end

### Test that a GCP instance has the correct machine type
    describe gcp_instance(project: 'silicon-vertex-398188', zone: 'us-east1-b', name: 'inspec-test') do
      its('machine_type') { should eq 'f1-micro' }
    end
