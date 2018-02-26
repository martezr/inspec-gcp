# gcp_image

Use the `gcp_image` InSpec audit resource to test properties of a single GCP image.

## Examples

The following examples show how to use this InSpec audit resource.

### Test that a GCP image does not exist

    describe gcp_image(project: 'silicon-vertex-398188', name: 'inspec-test') do
      it { should_not exist }
    end

### Test that a GCP image is using the correct source type

    describe gcp_image(project: 'silicon-vertex-398188', name: 'inspec-test') do
      its('source_type') { should eq 'RAW' }
    end

### Test that a GCP image has the family

    describe gcp_image(project: 'silicon-vertex-398188', name: 'inspec-test') do
      its('family') { should eq 'inspec-test-family' }
    end

### Test that a GCP image has the correct status

    describe gcp_image(project: 'silicon-vertex-398188', name: 'inspec-test') do
      its('status') { should eq 'ready' }
    end
