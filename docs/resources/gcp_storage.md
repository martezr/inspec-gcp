# gcp_storage

Use the `gcp_storage` InSpec audit resource to test properties of a GCP storage bucket.

## Examples

The following examples show how to use this InSpec audit resource.

### Test that a GCP storage bucket exists

    describe gcp_storage(name: 'inspec-test-bucket') do
      it { should exist }
    end

### Test the storage class of a GCP storage bucket

    describe gcp_storage(name: 'inspec-test-bucket') do
      its('storage_class') { should eq 'REGIONAL' }
    end

### Test the location of a GCP storage bucket

    describe gcp_storage(name: 'inspec-test-bucket') do
      its('location') { should eq 'US-CENTRAL1' }
    end

### Test the lifecycle status of a GCP storage bucket

    describe gcp_storage(name: 'inspec-test-bucket') do
      its('lifecycle') { should eq 'enabled' }
    end
